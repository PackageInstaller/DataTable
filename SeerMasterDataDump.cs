using System;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Collections;
using System.Collections.Generic;
using System.Text;

class SeerMasterDataDump
{
    static List<string> SearchDirs = new List<string>();
    static Dictionary<string, Assembly> Loaded =
        new Dictionary<string, Assembly>(StringComparer.OrdinalIgnoreCase);

    static Assembly LoadPath(string p)
    {
        if (!File.Exists(p)) return null;
        try
        {
            var a = Assembly.LoadFrom(p);
            Loaded[a.GetName().Name] = a;
            return a;
        }
        catch { return null; }
    }

    static Assembly OnResolve(object s, ResolveEventArgs e)
    {
        var name = new AssemblyName(e.Name).Name;
        if (Loaded.TryGetValue(name, out var hit)) return hit;
        foreach (var dir in SearchDirs)
        {
            foreach (var cand in new[] { name + ".dll", name + ".dll.bytes" })
            {
                var a = LoadPath(Path.Combine(dir, cand));
                if (a != null) return a;
            }
        }
        return null;
    }

    static string GetFileName(Type t, object inst)
    {
        try
        {
            var p = t.GetProperty(
                "fileName",
                BindingFlags.Public | BindingFlags.Instance | BindingFlags.FlattenHierarchy);
            return p == null ? null : p.GetValue(inst, null) as string;
        }
        catch { return null; }
    }

    static object ToJsonmable(object o, int depth)
    {
        if (o == null || depth > 40) return null;
        var t = o.GetType();
        if (o is string || t.IsPrimitive || o is decimal) return o;
        if (o is byte[]) return Convert.ToBase64String((byte[])o);
        if (t.IsEnum) return Convert.ToInt32(o);
        if (o is IDictionary)
        {
            var d = new Dictionary<string, object>();
            foreach (DictionaryEntry kv in (IDictionary)o)
                d[Convert.ToString(kv.Key)] = ToJsonmable(kv.Value, depth + 1);
            return d;
        }
        if (o is IEnumerable)
        {
            var list = new List<object>();
            foreach (var x in (IEnumerable)o) list.Add(ToJsonmable(x, depth + 1));
            return list;
        }
        var dict = new Dictionary<string, object>();
        PropertyInfo[] props;
        try { props = t.GetProperties(BindingFlags.Public | BindingFlags.Instance); }
        catch { return null; }
        foreach (var p in props)
        {
            if (!p.CanRead || p.GetIndexParameters().Length > 0) continue;
            if (p.Name == "fileName" || p.Name == "IsLoaded") continue;
            object v;
            try { v = p.GetValue(o, null); } catch { continue; }
            if (v == null) continue;
            dict[p.Name] = ToJsonmable(v, depth + 1);
        }
        return dict;
    }

    static object DumpRoot(object inst)
    {
        var t = inst.GetType();
        try
        {
            var m = t.GetMethod("getItems", BindingFlags.Public | BindingFlags.Instance);
            if (m != null && m.GetParameters().Length == 0)
            {
                var items = m.Invoke(inst, null);
                if (items != null)
                    return new Dictionary<string, object> { { "Items", ToJsonmable(items, 0) } };
            }
        }
        catch { }
        try
        {
            for (var bt = t; bt != null; bt = bt.BaseType)
            {
                var f = bt.GetField(
                    "data",
                    BindingFlags.Instance | BindingFlags.NonPublic | BindingFlags.Public);
                if (f != null)
                {
                    var items = f.GetValue(inst);
                    if (items != null)
                        return new Dictionary<string, object> { { "Items", ToJsonmable(items, 0) } };
                }
            }
        }
        catch { }
        return ToJsonmable(inst, 0);
    }

    static string Esc(string s)
    {
        var sb = new StringBuilder("\"");
        foreach (var c in s)
        {
            switch (c)
            {
                case '\\': sb.Append("\\\\"); break;
                case '"': sb.Append("\\\""); break;
                case '\n': sb.Append("\\n"); break;
                case '\r': sb.Append("\\r"); break;
                case '\t': sb.Append("\\t"); break;
                default:
                    if (c < 0x20) sb.AppendFormat("\\u{0:x4}", (int)c);
                    else sb.Append(c);
                    break;
            }
        }
        sb.Append('"');
        return sb.ToString();
    }

    static void WriteJson(object o, TextWriter w, int indent)
    {
        if (o == null) { w.Write("null"); return; }
        if (o is bool) { w.Write((bool)o ? "true" : "false"); return; }
        if (o is string) { w.Write(Esc((string)o)); return; }
        if (o is byte || o is sbyte || o is short || o is ushort || o is int || o is uint
            || o is long || o is ulong || o is float || o is double || o is decimal)
        {
            w.Write(Convert.ToString(o, System.Globalization.CultureInfo.InvariantCulture));
            return;
        }
        var pad = new string(' ', indent);
        var pad2 = new string(' ', indent + 2);
        if (o is IList)
        {
            var list = (IList)o;
            if (list.Count == 0) { w.Write("[]"); return; }
            w.Write("[\n");
            for (int i = 0; i < list.Count; i++)
            {
                w.Write(pad2); WriteJson(list[i], w, indent + 2);
                if (i + 1 < list.Count) w.Write(',');
                w.Write('\n');
            }
            w.Write(pad); w.Write(']');
            return;
        }
        if (o is IDictionary)
        {
            var d = (IDictionary)o;
            var keys = new List<string>();
            foreach (DictionaryEntry kv in d) keys.Add(Convert.ToString(kv.Key));
            if (keys.Count == 0) { w.Write("{}"); return; }
            w.Write("{\n");
            for (int i = 0; i < keys.Count; i++)
            {
                w.Write(pad2); w.Write(Esc(keys[i])); w.Write(": ");
                WriteJson(d[keys[i]], w, indent + 2);
                if (i + 1 < keys.Count) w.Write(',');
                w.Write('\n');
            }
            w.Write(pad); w.Write('}');
            return;
        }
        w.Write(Esc(Convert.ToString(o)));
    }

    static bool IsConfigRoot(Type t)
    {
        if (t == null || t.IsAbstract) return false;
        try
        {
            if (t.Name == "IRootInterface" && t.Namespace != null
                && t.Namespace.StartsWith("core.config"))
                return true;
            var bt = t.BaseType;
            while (bt != null)
            {
                var n = bt.IsGenericType ? bt.GetGenericTypeDefinition().Name : bt.Name;
                if (n.StartsWith("XlsConfigBase") || n.StartsWith("ConfigBase"))
                {
                    return t.GetProperty(
                        "fileName",
                        BindingFlags.Public | BindingFlags.Instance | BindingFlags.FlattenHierarchy)
                        != null;
                }
                bt = bt.BaseType;
            }
        }
        catch { }
        return false;
    }

    static void Main(string[] args)
    {
        if (args.Length < 3)
        {
            Console.Error.WriteLine(
                "usage: SeerMasterDataDump.exe <DllDir> <RawBinDir> <OutDir> [ExtraDllDir...]");
            Environment.Exit(2);
        }
        var dllDir = Path.GetFullPath(args[0]);
        var rawDir = Path.GetFullPath(args[1]);
        var outDir = Path.GetFullPath(args[2]);
        Directory.CreateDirectory(outDir);
        SearchDirs.Add(dllDir);
        for (int i = 3; i < args.Length; i++) SearchDirs.Add(Path.GetFullPath(args[i]));
        AppDomain.CurrentDomain.AssemblyResolve += OnResolve;

        foreach (var dir in SearchDirs)
        {
            if (!Directory.Exists(dir)) continue;
            foreach (var f in Directory.GetFiles(dir))
            {
                var bn = Path.GetFileName(f);
                if (bn.EndsWith(".dll") || bn.EndsWith(".dll.bytes")) LoadPath(f);
            }
        }

        Assembly logic;
        if (!Loaded.TryGetValue("GameLogic", out logic))
            logic = Assembly.LoadFrom(Path.Combine(dllDir, "GameLogic.dll.bytes"));

        Type[] types;
        try { types = logic.GetTypes(); }
        catch (ReflectionTypeLoadException ex)
        {
            types = ex.Types.Where(x => x != null).ToArray();
        }

        var roots = new Dictionary<string, Type>(StringComparer.OrdinalIgnoreCase);
        foreach (var t in types)
        {
            if (!IsConfigRoot(t)) continue;
            object inst;
            try { inst = Activator.CreateInstance(t); } catch { continue; }
            var fname = GetFileName(t, inst);
            if (string.IsNullOrEmpty(fname)) continue;
            if (!roots.ContainsKey(fname)) roots[fname] = t;
        }
        Console.WriteLine("roots " + roots.Count);

        int ok = 0, fail = 0, miss = 0;
        foreach (var bin in Directory.GetFiles(rawDir, "*.bin").OrderBy(x => x))
        {
            var name = Path.GetFileNameWithoutExtension(bin);
            Type t;
            if (!roots.TryGetValue(name, out t)) { miss++; continue; }
            try
            {
                var bytes = File.ReadAllBytes(bin);
                var inst = Activator.CreateInstance(t);
                var parse = t.GetMethod("Parse", new Type[] { typeof(byte[]) });
                if (parse == null) throw new Exception("no Parse(byte[])");
                parse.Invoke(inst, new object[] { bytes });
                var data = DumpRoot(inst);
                using (var w = new StreamWriter(
                    Path.Combine(outDir, name + ".json"), false, new UTF8Encoding(false)))
                {
                    WriteJson(data, w, 0);
                    w.Write('\n');
                }
                ok++;
                Console.WriteLine("OK " + name);
            }
            catch (Exception e)
            {
                fail++;
                Console.Error.WriteLine("FAIL " + name + ": " + (e.InnerException ?? e).Message);
            }
        }
        Console.WriteLine("ok=" + ok + " fail=" + fail + " miss_type=" + miss);
        if (ok == 0) Environment.Exit(1);
    }
}
