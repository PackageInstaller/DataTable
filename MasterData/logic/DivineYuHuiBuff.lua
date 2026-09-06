-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineyuhui/view/DivineYuHuiBuff.lua

module("logic.extensions.divineyuhui.view.DivineYuHuiBuff", package.seeall)

local DivineYuHuiBuff = class("DivineYuHuiBuff", CustomRightCell)

DivineYuHuiBuff.prefabUrl = "ui/views/divineyuhui/divineyuhuibuff.prefab"

function DivineYuHuiBuff:buildUI()
	self._buff = goutil.findChild(self.mainGO, "buff"):GetComponent(ComponentType.UIImageSpriteChange)
end

function DivineYuHuiBuff:setBuff(buffList)
	self._stateIdx = 1
	self._buffState = buffList[self._stateIdx]
	self._buffLength = #buffList
	self._buffList = buffList

	self._buff:SetState(self._buffState - 1)
	settimer(1, self.changeBuff, self)
	GameUtil.SetActive(self._buff.gameObject, true)
end

function DivineYuHuiBuff:clearBuff()
	removetimer(self.changeBuff, self)
	GameUtil.SetActive(self._buff.gameObject, false)
end

function DivineYuHuiBuff:changeBuff()
	self._stateIdx = self._stateIdx % self._buffLength + 1
	self._buffState = self._buffList[self._stateIdx]

	self._buff:SetState(self._buffState - 1)
end

function DivineYuHuiBuff:getBuffGo()
	return self.mainGO
end

return DivineYuHuiBuff
