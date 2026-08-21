using System.Text;
using Google.Protobuf.Reflection;

namespace DNFBDmp {
	/// <summary>
	/// 将 <see cref="FileDescriptorProto"/> 打印为可读的 proto3 源文本（用于从嵌入描述符恢复 .proto）。
	/// </summary>
	public static class ProtoFilePrinter {
		public static string Print(FileDescriptorProto file) {
			var sb = new StringBuilder();
			if (!string.IsNullOrEmpty(file.Syntax)) {
				sb.AppendLine($"syntax = \"{file.Syntax}\";");
				sb.AppendLine();
			}
			foreach (string dep in file.Dependency) {
				sb.AppendLine($"import \"{EscapeProtoString(dep)}\";");
			}
			if (file.Dependency.Count > 0)
				sb.AppendLine();
			if (!string.IsNullOrEmpty(file.Package)) {
				sb.AppendLine($"package {file.Package};");
				sb.AppendLine();
			}
			// 文件级 enum 先于 message（与常见 proto 写法一致；descriptor 中二者分属不同 repeated，此处固定为 enum → message）
			for (int i = 0; i < file.EnumType.Count; i++) {
				PrintEnum(sb, file.EnumType[i], 0);
				if (i < file.EnumType.Count - 1)
					sb.AppendLine();
			}
			if (file.EnumType.Count > 0 && file.MessageType.Count > 0)
				sb.AppendLine();
			for (int i = 0; i < file.MessageType.Count; i++) {
				PrintMessage(sb, file.MessageType[i], 0);
				if (i < file.MessageType.Count - 1)
					sb.AppendLine();
			}
			return sb.ToString().Replace("\r\n", "\n").TrimEnd() + "\n";
		}

		static void PrintMessage(StringBuilder sb, DescriptorProto msg, int indent) {
			string pad = new(' ', indent);
			sb.AppendLine($"{pad}message {msg.Name} {{");
			foreach (DescriptorProto nested in msg.NestedType)
				PrintMessage(sb, nested, indent + 2);
			foreach (EnumDescriptorProto en in msg.EnumType)
				PrintEnum(sb, en, indent + 2);
			IEnumerable<FieldDescriptorProto> ordered = msg.Field.OrderBy(f => f.Number);
			foreach (FieldDescriptorProto field in ordered) {
				if (field.HasOneofIndex)
					continue;
				PrintFieldLine(sb, field, indent + 2);
			}
			for (int oi = 0; oi < msg.OneofDecl.Count; oi++) {
				OneofDescriptorProto oneof = msg.OneofDecl[oi];
				sb.AppendLine($"{pad}  oneof {oneof.Name} {{");
				foreach (FieldDescriptorProto field in msg.Field.Where(f => f.HasOneofIndex && f.OneofIndex == oi).OrderBy(f => f.Number))
					PrintFieldLine(sb, field, indent + 4);
				sb.AppendLine($"{pad}  }}");
			}
			sb.AppendLine($"{pad}}}");
		}

		static void PrintFieldLine(StringBuilder sb, FieldDescriptorProto field, int indent) {
			string pad = new(' ', indent);
			var label = "";
			if (field.Label == FieldDescriptorProto.Types.Label.Repeated)
				label = "repeated ";
			else if (field.Proto3Optional)
				label = "optional ";
			string typeStr = FieldTypeString(field);
			sb.AppendLine($"{pad}{label}{typeStr} {field.Name} = {field.Number};");
		}

		static string FieldTypeString(FieldDescriptorProto field) {
			if (field.Type == FieldDescriptorProto.Types.Type.Message || field.Type == FieldDescriptorProto.Types.Type.Enum) {
				string tn = field.TypeName;
				if (tn.StartsWith("."))
					tn = tn.Substring(1);
				return tn;
			}
			return field.Type switch {
				FieldDescriptorProto.Types.Type.Double => "double",
				FieldDescriptorProto.Types.Type.Float => "float",
				FieldDescriptorProto.Types.Type.Int64 => "int64",
				FieldDescriptorProto.Types.Type.Uint64 => "uint64",
				FieldDescriptorProto.Types.Type.Int32 => "int32",
				FieldDescriptorProto.Types.Type.Fixed64 => "fixed64",
				FieldDescriptorProto.Types.Type.Fixed32 => "fixed32",
				FieldDescriptorProto.Types.Type.Bool => "bool",
				FieldDescriptorProto.Types.Type.String => "string",
				FieldDescriptorProto.Types.Type.Group => "group",
				FieldDescriptorProto.Types.Type.Bytes => "bytes",
				FieldDescriptorProto.Types.Type.Uint32 => "uint32",
				FieldDescriptorProto.Types.Type.Sfixed32 => "sfixed32",
				FieldDescriptorProto.Types.Type.Sfixed64 => "sfixed64",
				FieldDescriptorProto.Types.Type.Sint32 => "sint32",
				FieldDescriptorProto.Types.Type.Sint64 => "sint64",
				_ => "bytes",
			};
		}

		static void PrintEnum(StringBuilder sb, EnumDescriptorProto en, int indent) {
			string pad = new(' ', indent);
			sb.AppendLine($"{pad}enum {en.Name} {{");
			foreach (EnumValueDescriptorProto v in en.Value.OrderBy(x => x.Number)) {
				sb.AppendLine($"{pad}  {v.Name} = {v.Number};");
			}
			sb.AppendLine($"{pad}}}");
		}

		static string EscapeProtoString(string s) {
			return s.Replace("\\", "\\\\").Replace("\"", "\\\"");
		}
	}
}
