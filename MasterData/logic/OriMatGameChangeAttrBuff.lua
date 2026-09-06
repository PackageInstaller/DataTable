-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/model/buff/OriMatGameChangeAttrBuff.lua

module("logic.extensions.orimatgame.model.buff.OriMatGameChangeAttrBuff", package.seeall)

local OriMatGameChangeAttrBuff = class("OriMatGameChangeAttrBuff", OriMatGameBuffBase)

function OriMatGameChangeAttrBuff:onAdd(target)
	OriMatGameChangeAttrBuff.super.onAdd(self, target)

	if self._tiggerParam then
		for _, changeAttrStr in pairs(self._tiggerParam) do
			local changeParam = string.split(changeAttrStr, ":")

			if #changeParam == 2 then
				local attrName = changeParam[1]
				local attrValue = checknumber(changeParam[2])

				GameUtil.callBack(self._unit.updateAttr, self._unit, attrName, attrValue)
			end
		end
	end
end

function OriMatGameChangeAttrBuff:onRemove(unit)
	OriMatGameChangeAttrBuff.super.onRemove(self, unit)

	if self._tiggerParam then
		for _, changeAttrStr in pairs(self._tiggerParam) do
			local changeParam = string.split(changeAttrStr, ":")

			if #changeParam == 2 then
				local attrName = changeParam[1]
				local attrValue = checknumber(changeParam[2])

				GameUtil.callBack(self._unit.updateAttr, self._unit, attrName, -attrValue)
			end
		end
	end
end

function OriMatGameChangeAttrBuff:initComplete()
	OriMatGameChangeAttrBuff.super.initComplete(self)
end

return OriMatGameChangeAttrBuff
