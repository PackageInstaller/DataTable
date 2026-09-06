-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/model/buff/DefendCarrotChangeAttrBuff.lua

module("logic.extensions.defendcarrot.model.buff.DefendCarrotChangeAttrBuff", package.seeall)

local DefendCarrotChangeAttrBuff = class("DefendCarrotChangeAttrBuff", DefendCarrotBuffBase)

function DefendCarrotChangeAttrBuff:onAdd(target)
	DefendCarrotChangeAttrBuff.super.onAdd(self, target)

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

function DefendCarrotChangeAttrBuff:onRemove(unit)
	DefendCarrotChangeAttrBuff.super.onRemove(self, unit)

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

function DefendCarrotChangeAttrBuff:initComplete()
	DefendCarrotChangeAttrBuff.super.initComplete(self)
end

return DefendCarrotChangeAttrBuff
