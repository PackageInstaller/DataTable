from __future__ import annotations

import time

try:
    from rich.console import Console
    from rich.progress import (
        BarColumn,
        Progress,
        SpinnerColumn,
        TaskID,
        TextColumn,
        TimeElapsedColumn,
        TimeRemainingColumn,
    )

    _HAS_RICH = True
except ImportError:  # pragma: no cover
    _HAS_RICH = False
    TaskID = int  # type: ignore


def fmt_bytes(value: float) -> str:
    for unit in ("B", "KB", "MB", "GB", "TB"):
        if value < 1024 or unit == "TB":
            return f"{value:.1f}{unit}" if unit != "B" else f"{int(value)}B"
        value /= 1024
    return f"{value:.1f}TB"


class ProgressUI:

    def __init__(self, enabled: bool = True) -> None:
        self.enabled = enabled and _HAS_RICH
        self.progress = None
        self._started: dict[int, float] = {}
        if self.enabled:
            self.progress = Progress(
                SpinnerColumn(),
                TextColumn("[bold cyan]{task.description}"),
                BarColumn(bar_width=None),
                TextColumn("{task.fields[info]}"),
                TimeElapsedColumn(),
                TimeRemainingColumn(),
                console=Console(),
                transient=False,
            )

    def __enter__(self) -> "ProgressUI":
        if self.progress:
            self.progress.start()
        return self

    def __exit__(self, *exc) -> None:
        if self.progress:
            self.progress.stop()

    def log(self, message: str) -> None:
        if self.progress:
            from rich.text import Text

            stamp = time.strftime("%H:%M:%S")
            self.progress.console.print(Text(f"[{stamp}] {message}"))
        else:
            print(message, flush=True)


    def add_download(self, name: str, total: int) -> TaskID:
        if not self.progress:
            return 0
        task = self.progress.add_task(f"下载 {name}", total=total or None, info="0B / ?")
        self._started[task] = time.monotonic()
        return task

    def update_download(self, task: TaskID, done: int, total: int) -> None:
        if not self.progress or task is None:
            return
        elapsed = max(time.monotonic() - self._started.get(task, time.monotonic()), 1e-6)
        speed = done / elapsed
        info = f"{fmt_bytes(done)} / {fmt_bytes(total)}  {fmt_bytes(speed)}/s"
        self.progress.update(task, completed=done, total=total or None, info=info)

    def finish_download(self, task: TaskID) -> None:
        if not self.progress or task is None:
            return
        total = self.progress.tasks[task].total or 0
        self.progress.update(task, completed=total, info=f"{fmt_bytes(total)} / {fmt_bytes(total)}")

    def add_extract(self, package: str, total: int) -> TaskID:
        if not self.progress:
            return 0
        task = self.progress.add_task(f"解密 {package}", total=total, info=f"0/{total} bundles")
        return task

    def advance(self, task: TaskID, amount: int = 1) -> None:
        if not self.progress or task is None:
            return
        self.progress.advance(task, amount)
        t = self.progress.tasks[task]
        self.progress.update(task, info=f"{int(t.completed)}/{int(t.total or 0)} bundles")

    def set_description(self, task: TaskID, text: str) -> None:
        if not self.progress or task is None:
            return
        self.progress.update(task, description=text)
