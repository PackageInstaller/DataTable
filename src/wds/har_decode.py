"""Decode every /api/* response body from a HAR capture into field-named JSON.

Field names are resolved automatically from the game metadata instead of being
hard-coded: [MemoryTable]/[Key] types from cs/il2cpp.cs and ApiClient method
return types from il2cpp.json.  The wire format itself lives in codec.py.
"""

from __future__ import annotations

import datetime as _dt
import json
from pathlib import Path
from typing import Any

from . import codec
from .metadata import (
    build_class_field_index,
    build_method_index,
    default_for,
    expand_fields,
    field_names,
)


def resolve_endpoint(
    path: str,
    payloads: list[Any],
    methods: dict[str, dict[str, tuple[str, bool]]],
    types: dict[str, list[tuple[int, str, str]]],
) -> tuple[
    str | None,
    str | None,
    list[str] | None,
    list[tuple[str, str] | None] | None,
]:
    """Resolve (method, response type, field names, field slots) for an API path."""
    segs = [s for s in path.split("/") if s]
    if segs and segs[0].lower() == "api":
        segs = segs[1:]
    if not segs:
        return None, None, None, None

    url_controller = segs[0]
    url_action = segs[-1]
    if url_action.endswith("Async"):
        url_action = url_action[:-5]

    lengths = {len(p) for p in payloads if isinstance(p, list)}
    main_len = max(lengths) if lengths else None

    scored: list[tuple[int, str, str, bool, list[tuple[str, str] | None]]] = []
    for controller, actions in methods.items():
        ctrl_ok = (
            controller.lower() == url_controller.lower()
            or controller.lower() == url_controller.rstrip("s").lower()
            or controller.lower().rstrip("s") == url_controller.lower()
        )
        for action, (rtype, is_array) in actions.items():
            a_low = action.lower()
            u_low = url_action.lower()
            action_ok = (
                a_low == u_low
                or (len(u_low) >= 4 and a_low.startswith(u_low))
                or (len(u_low) >= 4 and a_low.endswith(u_low))
            )
            score = 0
            if ctrl_ok:
                score += 1000
            if action_ok:
                score += 500
            elif len(u_low) >= 4 and u_low in a_low:
                score += 100
            slots = expand_fields(types.get(rtype) or [])
            if main_len is not None and slots and len(slots) == main_len:
                score += 100
            if score:
                scored.append((score, controller, action, rtype, slots))

    if scored:
        scored.sort(key=lambda x: -x[0])
        _, c, a, rtype, slots = scored[0]
        return f"{c}_{a}", rtype, field_names(slots), slots or None

    if main_len is not None:
        for tname, triples in types.items():
            slots = expand_fields(triples)
            if slots and len(slots) == main_len:
                return None, tname, field_names(slots), slots
    return None, None, None, None


def map_fields(value: Any, field_defs: list[tuple[str, str] | None] | None) -> Any:
    """Apply field names/types to arrays (positional fallback otherwise)."""
    if isinstance(value, msgpack_timestamp()):
        return codec.to_json_value(value)
    if isinstance(value, list):
        is_union_pair = (
            len(value) == 2
            and isinstance(value[0], int)
            and isinstance(value[1], list)
        )
        if is_union_pair:
            return [map_fields(v, None) for v in value]
        if field_defs and len(value) == len(field_defs):
            out: dict[str, Any] = {}
            for i, v in enumerate(value):
                slot = field_defs[i] if i < len(field_defs) else None
                name = slot[0] if slot else f"field_{i}"
                out[name] = map_fields(v, field_defs)
            for i in range(len(value), len(field_defs)):
                slot = field_defs[i]
                name = slot[0] if slot else f"field_{i}"
                out[name] = default_for(slot[1]) if slot else None
            return out
        return [map_fields(v, field_defs) for v in value]
    if isinstance(value, dict):
        return {k: map_fields(v, None) for k, v in value.items()}
    return codec.to_json_value(value)


def msgpack_timestamp():
    import msgpack

    return msgpack.ext.Timestamp


def decode_har(
    har_path: str,
    il2cpp_cs_path: str,
    il2cpp_json_path: str,
) -> dict[str, Any]:
    """Decode all API entries of a HAR; returns the summary document."""
    from .metadata import load_il2cpp_cs

    with open(har_path, encoding="utf-8") as f:
        har = json.load(f)

    types = build_class_field_index(load_il2cpp_cs(il2cpp_cs_path))
    methods = build_method_index(il2cpp_json_path)

    endpoints: dict[str, dict[str, Any]] = {}
    for i, entry in enumerate(har["log"]["entries"]):
        url = entry["request"]["url"]
        if "/api/" not in url:
            continue
        path = "/api/" + url.split("/api/", 1)[1].split("?")[0]
        body = entry["response"]["content"].get("text", "").encode("latin-1")
        try:
            payloads = codec.decode_response(body)
        except Exception as ex:  # noqa: BLE001 - keep decoding the rest
            payloads = [{"$decode_error": str(ex)}]

        method, rtype, names, slots = resolve_endpoint(path, payloads, methods, types)
        entry_doc = {
            "index": i,
            "data": [map_fields(p, slots) for p in payloads],
        }
        if path not in endpoints:
            endpoints[path] = {
                "api": path,
                "method": method,
                "response_type": rtype,
                "fields": names,
                "entries": [],
            }
        endpoints[path]["entries"].append(entry_doc)

    return {
        "generated_at": _dt.datetime.now(_dt.timezone.utc).isoformat(),
        "har": Path(har_path).name,
        "count": len(endpoints),
        "apis": list(endpoints.values()),
    }
