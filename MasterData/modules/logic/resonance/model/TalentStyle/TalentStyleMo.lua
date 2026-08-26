-- chunkname: @modules/logic/resonance/model/TalentStyle/TalentStyleMo.lua

module("modules.logic.resonance.model.TalentStyle.TalentStyleMo", package.seeall)

local TalentStyleMo = class("TalentStyleMo")

function TalentStyleMo:ctor()
	self._styleCo = nil
	self._orginId = nil
	self._replaceId = nil
	self._styleId = nil
	self._isUse = false
	self._isSelect = false
	self._isNew = false
	self._isUnlock = false
	self._unlockPercent = 0
	self._hotUnlockStyle = nil
end

function TalentStyleMo:setMo(co, orginId, replaceId)
	self._styleCo = co
	self._orginId = orginId
	self._replaceId = replaceId
	self._styleId = co.styleId
end

function TalentStyleMo:isCanUnlock(heroLevel)
	if self._styleCo and self._styleCo.level then
		if not self._styleCo.level then
			local unlockLevel = 0

			return unlockLevel <= heroLevel
		end
	end
end

function TalentStyleMo:onRefresh(useId, selectId, isUnlock)
	self._isUse = useId == self._styleId
	self._isSelect = selectId == self._styleId
	self._isUnlock = isUnlock
end

function TalentStyleMo:setShowInfo()
	return
end

function TalentStyleMo:getStyleTag()
	self._name = self._name or self._styleCo.name

	if string.nilorempty(self._tagStr) then
		local tag = self._styleCo.tag

		self._tagStr = ""

		if not string.nilorempty(tag) then
			local split = string.splitToNumber(tag, "#")

			for _, v in ipairs(split) do
				local co = lua_character_attribute.configDict[v]

				if co then
					if not co.name then
						local t = luaLang("talent_style_special_tag_" .. v)

						self._tagStr = string.nilorempty(self._tagStr) and t or string.format("%s    %s", self._tagStr, t)
					end
				end
			end
		end
	end

	return self._name, self._tagStr
end

function TalentStyleMo:getStyleTagIcon()
	if not self._growTagIcon or not self._nomalTagIcon then
		local tagicon = self._styleCo.tagicon

		if tagicon then
			local numIcon = tonumber(tagicon)

			if numIcon and numIcon < 10 then
				tagicon = "0" .. numIcon
			end

			self._growTagIcon = "fg_" .. tagicon
			self._nomalTagIcon = "fz_" .. tagicon
		end
	end

	return self._growTagIcon, self._nomalTagIcon
end

function TalentStyleMo:setNew(isNew)
	self._isNew = isNew and self._styleId ~= 0
end

function TalentStyleMo:setUnlockPercent(percent)
	self._unlockPercent = percent
end

function TalentStyleMo:getUnlockPercent()
	return self._unlockPercent or 0
end

function TalentStyleMo:setHotUnlockStyle(isHot)
	self._hotUnlockStyle = isHot
end

function TalentStyleMo:isHotUnlock()
	return self._hotUnlockStyle
end

return TalentStyleMo
