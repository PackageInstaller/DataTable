-- chunkname: @/tmp/or_script/lua_compile/dm/assets/Strings.lua

Strings = {
	_default = ""
}

function Strings:find(id)
	local content

	repeat
		if ConfigReader ~= nil then
			local strId = tostring(id)
			local r = ConfigReader:getRecordById("Translate", strId)

			if r ~= nil then
				content = r[GameLanguageTypeForTransLate[getCurrentLanguage()]]

				if content ~= nil then
					break
				end
			end
		end

		if StringConstants ~= nil then
			content = StringConstants[id]

			if StringConstants[id] ~= nil then
				-- block empty
			end

			break
		end
	until true

	if content ~= nil then
		local contentType = type(content)

		if contentType == "string" then
			return content
		elseif contentType == "table" then
			local total = #content

			if total == 1 then
				return content[1]
			else
				return content[math.random(1, total)]
			end
		end
	end

	return nil
end

function Strings:setDefault(string)
	self._default = string
end

function Strings:get(id, env, filters)
	local text = self:find(id)

	if text == nil then
		return id
	end

	if env ~= nil and type(env) == "table" then
		local tmpl = TextTemplate:new(text)

		text = tmpl:stringify(env, filters)
	end

	return text
end

function Strings:newTemplate(id)
	local text = self:find(id)

	if text == nil then
		return nil
	end

	return TextTemplate:new(text)
end
