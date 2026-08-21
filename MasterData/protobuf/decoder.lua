local var_0_0 = string
local var_0_1 = table
local var_0_2 = assert
local var_0_3 = ipairs
local var_0_4 = error
local var_0_5 = print
local var_0_6 = require("pb")
local var_0_7 = require("protobuf.encoder")
local var_0_8 = require("protobuf.wire_format")

module("protobuf.decoder")

local var_0_9 = var_0_6.varint_decoder
local var_0_10 = var_0_6.signed_varint_decoder
local var_0_11 = var_0_6.varint_decoder
local var_0_12 = var_0_6.signed_varint_decoder
local var_0_13 = var_0_6.varint_decoder64
local var_0_14 = var_0_6.signed_varint_decoder64

ReadTag = var_0_6.read_tag

local function var_0_15(arg_1_0, arg_1_1)
	return function(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		if arg_2_2 then
			local var_2_0 = var_0_9

			return function(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
				local var_3_0 = arg_3_4[arg_2_3]

				if var_3_0 == nil then
					var_3_0 = arg_2_4(arg_3_3)
					arg_3_4[arg_2_3] = var_3_0
				end

				local var_3_1
				local var_3_2, var_3_3 = var_2_0(arg_3_0, arg_3_1)

				arg_3_1 = var_3_3

				local var_3_4 = var_3_2 + arg_3_1

				if arg_3_2 < var_3_4 then
					var_0_4("Truncated message.")
				end

				local var_3_5

				while arg_3_1 < var_3_4 do
					local var_3_6

					var_3_6, arg_3_1 = arg_1_1(arg_3_0, arg_3_1)
					var_3_0[#var_3_0 + 1] = var_3_6
				end

				if var_3_4 < arg_3_1 then
					var_3_0:remove(#var_3_0)
					var_0_4("Packed element was truncated.")
				end

				return arg_3_1
			end
		elseif arg_2_1 then
			local var_2_1 = var_0_7.TagBytes(arg_2_0, arg_1_0)
			local var_2_2 = #var_2_1
			local var_2_3 = var_0_0.sub

			return function(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
				local var_4_0 = arg_4_4[arg_2_3]

				if var_4_0 == nil then
					var_4_0 = arg_2_4(arg_4_3)
					arg_4_4[arg_2_3] = var_4_0
				end

				while true do
					local var_4_1, var_4_2 = arg_1_1(arg_4_0, arg_4_1)

					var_4_0:append(var_4_1)

					arg_4_1 = var_4_2 + var_2_2

					if var_2_3(arg_4_0, var_4_2 + 1, arg_4_1) ~= var_2_1 or arg_4_2 <= var_4_2 then
						if arg_4_2 < var_4_2 then
							var_0_4("Truncated message.")
						end

						return var_4_2
					end
				end
			end
		else
			return function(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
				arg_5_4[arg_2_3], arg_5_1 = arg_1_1(arg_5_0, arg_5_1)

				if arg_5_2 < arg_5_1 then
					arg_5_4[arg_2_3] = nil

					var_0_4("Truncated message.")
				end

				return arg_5_1
			end
		end
	end
end

local function var_0_16(arg_6_0, arg_6_1, arg_6_2)
	local function var_6_0(arg_7_0, arg_7_1)
		local var_7_0, var_7_1 = arg_6_1(arg_7_0, arg_7_1)

		return arg_6_2(var_7_0), var_7_1
	end

	return var_0_15(arg_6_0, var_6_0)
end

local function var_0_17(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = var_0_6.struct_unpack

	function InnerDecode(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_1 + arg_8_1

		return var_8_0(arg_8_2, arg_9_0, arg_9_1), var_9_0
	end

	return var_0_15(arg_8_0, InnerDecode)
end

local function var_0_18(arg_10_0)
	return arg_10_0 ~= 0
end

Int32Decoder = var_0_15(var_0_8.WIRETYPE_VARINT, var_0_12)
EnumDecoder = Int32Decoder
Int64Decoder = var_0_15(var_0_8.WIRETYPE_VARINT, var_0_14)
UInt32Decoder = var_0_15(var_0_8.WIRETYPE_VARINT, var_0_11)
UInt64Decoder = var_0_15(var_0_8.WIRETYPE_VARINT, var_0_13)
SInt32Decoder = var_0_16(var_0_8.WIRETYPE_VARINT, var_0_11, var_0_8.ZigZagDecode32)
SInt64Decoder = var_0_16(var_0_8.WIRETYPE_VARINT, var_0_13, var_0_8.ZigZagDecode64)
Fixed32Decoder = var_0_17(var_0_8.WIRETYPE_FIXED32, 4, var_0_0.byte("I"))
Fixed64Decoder = var_0_17(var_0_8.WIRETYPE_FIXED64, 8, var_0_0.byte("Q"))
SFixed32Decoder = var_0_17(var_0_8.WIRETYPE_FIXED32, 4, var_0_0.byte("i"))
SFixed64Decoder = var_0_17(var_0_8.WIRETYPE_FIXED64, 8, var_0_0.byte("q"))
FloatDecoder = var_0_17(var_0_8.WIRETYPE_FIXED32, 4, var_0_0.byte("f"))
DoubleDecoder = var_0_17(var_0_8.WIRETYPE_FIXED64, 8, var_0_0.byte("d"))
BoolDecoder = var_0_16(var_0_8.WIRETYPE_VARINT, var_0_9, var_0_18)

function StringDecoder(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = var_0_9
	local var_11_1 = var_0_0.sub

	var_0_2(not arg_11_2)

	if arg_11_1 then
		local var_11_2 = var_0_7.TagBytes(arg_11_0, var_0_8.WIRETYPE_LENGTH_DELIMITED)
		local var_11_3 = #var_11_2

		return function(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
			local var_12_0 = arg_12_4[arg_11_3]

			if var_12_0 == nil then
				var_12_0 = arg_11_4(arg_12_3)
				arg_12_4[arg_11_3] = var_12_0
			end

			while true do
				local var_12_1
				local var_12_2
				local var_12_3, var_12_4 = var_11_0(arg_12_0, arg_12_1)

				arg_12_1 = var_12_4

				local var_12_5 = arg_12_1 + var_12_3

				if arg_12_2 < var_12_5 then
					var_0_4("Truncated string.")
				end

				var_12_0:append(var_11_1(arg_12_0, arg_12_1 + 1, var_12_5))

				arg_12_1 = var_12_5 + var_11_3

				if var_11_1(arg_12_0, var_12_5 + 1, arg_12_1) ~= var_11_2 or var_12_5 == arg_12_2 then
					return var_12_5
				end
			end
		end
	else
		return function(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
			local var_13_0
			local var_13_1
			local var_13_2, var_13_3 = var_11_0(arg_13_0, arg_13_1)

			arg_13_1 = var_13_3

			local var_13_4 = arg_13_1 + var_13_2

			if arg_13_2 < var_13_4 then
				var_0_4("Truncated string.")
			end

			arg_13_4[arg_11_3] = var_11_1(arg_13_0, arg_13_1 + 1, var_13_4)

			return var_13_4
		end
	end
end

function BytesDecoder(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = var_0_9
	local var_14_1 = var_0_0.sub

	var_0_2(not arg_14_2)

	if arg_14_1 then
		local var_14_2 = var_0_7.TagBytes(arg_14_0, var_0_8.WIRETYPE_LENGTH_DELIMITED)
		local var_14_3 = #var_14_2

		return function(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
			local var_15_0 = arg_15_4[arg_14_3]

			if var_15_0 == nil then
				var_15_0 = arg_14_4(arg_15_3)
				arg_15_4[arg_14_3] = var_15_0
			end

			while true do
				local var_15_1
				local var_15_2
				local var_15_3, var_15_4 = var_14_0(arg_15_0, arg_15_1)

				arg_15_1 = var_15_4

				local var_15_5 = arg_15_1 + var_15_3

				if arg_15_2 < var_15_5 then
					var_0_4("Truncated string.")
				end

				var_15_0:append(var_14_1(arg_15_0, arg_15_1 + 1, var_15_5))

				arg_15_1 = var_15_5 + var_14_3

				if var_14_1(arg_15_0, var_15_5 + 1, arg_15_1) ~= var_14_2 or var_15_5 == arg_15_2 then
					return var_15_5
				end
			end
		end
	else
		return function(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
			local var_16_0
			local var_16_1
			local var_16_2, var_16_3 = var_14_0(arg_16_0, arg_16_1)

			arg_16_1 = var_16_3

			local var_16_4 = arg_16_1 + var_16_2

			if arg_16_2 < var_16_4 then
				var_0_4("Truncated string.")
			end

			arg_16_4[arg_14_3] = var_14_1(arg_16_0, arg_16_1 + 1, var_16_4)

			return var_16_4
		end
	end
end

function MessageDecoder(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = var_0_9
	local var_17_1 = var_0_0.sub

	var_0_2(not arg_17_2)

	if arg_17_1 then
		local var_17_2 = var_0_7.TagBytes(arg_17_0, var_0_8.WIRETYPE_LENGTH_DELIMITED)
		local var_17_3 = #var_17_2

		return function(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
			local var_18_0 = arg_18_4[arg_17_3]

			if var_18_0 == nil then
				var_18_0 = arg_17_4(arg_18_3)
				arg_18_4[arg_17_3] = var_18_0
			end

			while true do
				local var_18_1
				local var_18_2
				local var_18_3, var_18_4 = var_17_0(arg_18_0, arg_18_1)

				arg_18_1 = var_18_4

				local var_18_5 = arg_18_1 + var_18_3

				if arg_18_2 < var_18_5 then
					var_0_4("Truncated message.")
				end

				if var_18_0:add():_InternalParse(arg_18_0, arg_18_1, var_18_5) ~= var_18_5 then
					var_0_4("Unexpected end-group tag.")
				end

				arg_18_1 = var_18_5 + var_17_3

				if var_17_1(arg_18_0, var_18_5 + 1, arg_18_1) ~= var_17_2 or var_18_5 == arg_18_2 then
					return var_18_5
				end
			end
		end
	else
		return function(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
			local var_19_0 = arg_19_4[arg_17_3]

			if var_19_0 == nil then
				var_19_0 = arg_17_4(arg_19_3)
				arg_19_4[arg_17_3] = var_19_0
			end

			local var_19_1
			local var_19_2
			local var_19_3, var_19_4 = var_17_0(arg_19_0, arg_19_1)

			arg_19_1 = var_19_4

			local var_19_5 = arg_19_1 + var_19_3

			if arg_19_2 < var_19_5 then
				var_0_4("Truncated message.")
			end

			if var_19_0:_InternalParse(arg_19_0, arg_19_1, var_19_5) ~= var_19_5 then
				var_0_4("Unexpected end-group tag.")
			end

			return var_19_5
		end
	end
end

function _SkipVarint(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0
	local var_20_1

	var_20_1, arg_20_1 = var_0_9(arg_20_0, arg_20_1)

	return arg_20_1
end

function _SkipFixed64(arg_21_0, arg_21_1, arg_21_2)
	arg_21_1 = arg_21_1 + 8

	if arg_21_2 < arg_21_1 then
		var_0_4("Truncated message.")
	end

	return arg_21_1
end

function _SkipLengthDelimited(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0
	local var_22_1, var_22_2 = var_0_9(arg_22_0, arg_22_1)

	arg_22_1 = var_22_2
	arg_22_1 = arg_22_1 + var_22_1

	if arg_22_2 < arg_22_1 then
		var_0_4("Truncated message.")
	end

	return arg_22_1
end

function _SkipFixed32(arg_23_0, arg_23_1, arg_23_2)
	arg_23_1 = arg_23_1 + 4

	if arg_23_2 < arg_23_1 then
		var_0_4("Truncated message.")
	end

	return arg_23_1
end

function _RaiseInvalidWireType(arg_24_0, arg_24_1, arg_24_2)
	var_0_4("Tag had invalid wire type.")
end

function _FieldSkipper()
	WIRETYPE_TO_SKIPPER = {
		_SkipVarint,
		_SkipFixed64,
		_SkipLengthDelimited,
		_SkipGroup,
		_EndGroup,
		_SkipFixed32,
		_RaiseInvalidWireType,
		_RaiseInvalidWireType
	}

	local var_25_0 = var_0_0.byte
	local var_25_1 = var_0_0.sub

	return function(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
		local var_26_0 = var_25_0(var_25_1(arg_26_3, 1, 1)) % 8 + 1

		return WIRETYPE_TO_SKIPPER[var_26_0](arg_26_0, arg_26_1, arg_26_2)
	end
end

SkipField = _FieldSkipper()
