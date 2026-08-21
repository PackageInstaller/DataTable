local var_0_0 = require("pb")

module("protobuf.wire_format")

WIRETYPE_VARINT = 0
WIRETYPE_FIXED64 = 1
WIRETYPE_LENGTH_DELIMITED = 2
WIRETYPE_START_GROUP = 3
WIRETYPE_END_GROUP = 4
WIRETYPE_FIXED32 = 5
_WIRETYPE_MAX = 5

local function var_0_1(arg_1_0)
	if arg_1_0 <= 127 then
		return 1
	end

	if arg_1_0 <= 16383 then
		return 2
	end

	if arg_1_0 <= 2097151 then
		return 3
	end

	if arg_1_0 <= 268435455 then
		return 4
	end

	return 5
end

function PackTag(arg_2_0, arg_2_1)
	return arg_2_0 * 8 + arg_2_1
end

function UnpackTag(arg_3_0)
	local var_3_0 = arg_3_0 % 8

	return (arg_3_0 - var_3_0) / 8, var_3_0
end

ZigZagEncode32 = var_0_0.zig_zag_encode32
ZigZagDecode32 = var_0_0.zig_zag_decode32
ZigZagEncode64 = var_0_0.zig_zag_encode64
ZigZagDecode64 = var_0_0.zig_zag_decode64

function Int32ByteSize(arg_4_0, arg_4_1)
	return Int64ByteSize(arg_4_0, arg_4_1)
end

function Int32ByteSizeNoTag(arg_5_0)
	return var_0_1(arg_5_0)
end

function Int64ByteSize(arg_6_0, arg_6_1)
	return UInt64ByteSize(arg_6_0, arg_6_1)
end

function UInt32ByteSize(arg_7_0, arg_7_1)
	return UInt64ByteSize(arg_7_0, arg_7_1)
end

function UInt64ByteSize(arg_8_0, arg_8_1)
	return TagByteSize(arg_8_0) + var_0_1(arg_8_1)
end

function SInt32ByteSize(arg_9_0, arg_9_1)
	return UInt32ByteSize(arg_9_0, ZigZagEncode(arg_9_1))
end

function SInt64ByteSize(arg_10_0, arg_10_1)
	return UInt64ByteSize(arg_10_0, ZigZagEncode(arg_10_1))
end

function Fixed32ByteSize(arg_11_0, arg_11_1)
	return TagByteSize(arg_11_0) + 4
end

function Fixed64ByteSize(arg_12_0, arg_12_1)
	return TagByteSize(arg_12_0) + 8
end

function SFixed32ByteSize(arg_13_0, arg_13_1)
	return TagByteSize(arg_13_0) + 4
end

function SFixed64ByteSize(arg_14_0, arg_14_1)
	return TagByteSize(arg_14_0) + 8
end

function FloatByteSize(arg_15_0, arg_15_1)
	return TagByteSize(arg_15_0) + 4
end

function DoubleByteSize(arg_16_0, arg_16_1)
	return TagByteSize(arg_16_0) + 8
end

function BoolByteSize(arg_17_0, arg_17_1)
	return TagByteSize(arg_17_0) + 1
end

function EnumByteSize(arg_18_0, arg_18_1)
	return UInt32ByteSize(arg_18_0, arg_18_1)
end

function StringByteSize(arg_19_0, arg_19_1)
	return BytesByteSize(arg_19_0, arg_19_1)
end

function BytesByteSize(arg_20_0, arg_20_1)
	return TagByteSize(arg_20_0) + var_0_1(#arg_20_1) + #arg_20_1
end

function MessageByteSize(arg_21_0, arg_21_1)
	return TagByteSize(arg_21_0) + var_0_1(arg_21_1.ByteSize()) + arg_21_1.ByteSize()
end

function MessageSetItemByteSize(arg_22_0, arg_22_1)
	local var_22_0 = 2 * TagByteSize(1) + TagByteSize(2) + TagByteSize(3) + var_0_1(arg_22_0)
	local var_22_1 = arg_22_1.ByteSize()

	return var_22_0 + var_0_1(var_22_1) + var_22_1
end

function TagByteSize(arg_23_0)
	return var_0_1(PackTag(arg_23_0, 0))
end
