local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = assert
local var_0_3 = encode
local var_0_4 = crypto.aes
local var_0_5 = crypto.random
local var_0_6 = crypto.X25519
local var_0_7 = crypto.ED25519
local var_0_8 = crypto.sha256
local var_0_9 = {
	base64 = {
		encode = encode.base64_encode,
		decode = encode.base64_decode
	},
	hex = {
		encode = encode.binary_to_hex,
		decode = encode.hex_to_binary
	},
	binary = {
		encode = function(arg_1_0)
			return arg_1_0
		end,
		decode = function(arg_2_0)
			return arg_2_0
		end
	}
}

lx.define_class("secretbox", function(arg_3_0)
	function arg_3_0:reset()
		self._ED25519.public_key = nil
		self._ED25519.private_key = nil
		self._X25519.public_value = nil
		self._X25519.private_key = nil
		self._X25519.secret = nil
		self._secret = nil
	end

	function arg_3_0.set_code(arg_5_0, arg_5_1)
		var_0_2(var_0_9[arg_5_1], string.format("unknow code:'%s'", tostring(arg_5_1)))

		arg_5_0._code = arg_5_1
	end

	function arg_3_0.set_secret(arg_6_0, arg_6_1)
		arg_6_0._secret = arg_6_1
	end

	function arg_3_0:set_ED25519(arg_7_1, arg_7_2)
		self._ED25519.public_key = arg_7_1
		self._ED25519.private_key = arg_7_2
	end

	function arg_3_0:generate_key_exchange()
		self._X25519.public_value, self._X25519.private_key = var_0_6.generate_keypair()

		return self:__encrypt(self._X25519.public_value)
	end

	function arg_3_0:generate_secret(arg_9_1)
		arg_9_1 = self:__decrypt(arg_9_1)

		if not arg_9_1 then
			return nil
		end

		self._X25519.secret = var_0_6.shared_secret(self._X25519.private_key, arg_9_1)

		return self._X25519.secret
	end

	function arg_3_0:sign(arg_10_1)
		if self._X25519.secret then
			return var_0_8.hmac(self._X25519.secret, arg_10_1)
		end

		if self._ED25519.private_key then
			local var_10_0 = var_0_7.sign(self._ED25519.private_key, arg_10_1)

			var_10_0 = var_10_0 and var_0_3.binary_to_hex(var_10_0)

			return var_10_0
		end

		if self._ED25519.public_key then
			return var_0_8.hmac(self._ED25519.public_key, arg_10_1)
		end

		if self._secret then
			return var_0_8.hmac(self._secret, arg_10_1)
		end

		var_0_1.error("unknow how to sign")
	end

	function arg_3_0:verify(arg_11_1, arg_11_2)
		if self._X25519.secret then
			return var_0_8.hmac(self._X25519.secret, arg_11_1) == arg_11_2
		end

		if self._ED25519.private_key then
			return var_0_8.hmac(self._ED25519.public_key, arg_11_1) == arg_11_2
		end

		if self._ED25519.public_key then
			arg_11_2 = var_0_3.hex_to_binary(arg_11_2)

			if arg_11_2 then
				return var_0_7.verify(self._ED25519.public_key, arg_11_1, arg_11_2)
			end

			return false
		end

		if self._secret then
			return var_0_8.hmac(self._secret, arg_11_1) == arg_11_2
		end

		var_0_1.error("unknow how to verify")
	end

	function arg_3_0:encrypt(arg_12_1, arg_12_2)
		return self:__encrypt(arg_12_1, arg_12_2)
	end

	function arg_3_0:decrypt(arg_13_1, arg_13_2)
		return self:__decrypt(arg_13_1, arg_13_2)
	end

	function arg_3_0:__get_secret()
		return self._X25519.secret or self._secret
	end

	function arg_3_0:__encrypt(arg_15_1, arg_15_2)
		local var_15_0

		if not arg_15_2 then
			arg_15_2 = self._code
			var_15_0 = var_0_5.bytes(12)
		end

		arg_15_1 = var_0_4.gcm_encrypt(256, self:__get_secret(), arg_15_1, var_15_0)
		arg_15_1 = var_15_0 .. arg_15_1

		if not var_0_9[arg_15_2] then
			return arg_15_1
		end

		return var_0_9[arg_15_2].encode(arg_15_1)
	end

	function arg_3_0:__decrypt(arg_16_1, arg_16_2)
		arg_16_2 = arg_16_2 or self._code

		if var_0_9[arg_16_2] then
			arg_16_1 = var_0_9[arg_16_2].decode(arg_16_1)
		end

		if not arg_16_1 then
			do return nil end

			arg_16_1 = arg_16_1:sub(13)
		end

		return var_0_4.gcm_decrypt(256, self:__get_secret(), arg_16_1, (arg_16_1:sub(1, 12)))
	end
end)

function var_0_0.create(arg_17_0)
	local var_17_0 = var_0_1.class("secretbox")

	var_17_0._ED25519 = {}
	var_17_0._X25519 = {}
	var_17_0._secret = nil
	var_17_0._code = "base64"

	return var_17_0
end

return var_0_0
