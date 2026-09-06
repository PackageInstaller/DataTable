-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/view/SxGameCombo.lua

module("logic.extensions.sxgame.view.SxGameCombo", package.seeall)

local SxGameCombo = class("SxGameCombo")

function SxGameCombo:ctor(componetContainer)
	self._container = componetContainer

	self:_onBuild()
end

function SxGameCombo:_onBuild()
	self._comboNum = goutil.findChild(self._container, "Text"):GetComponent(ComponentType.UIImgNumeralText)
end

function SxGameCombo:setCombo(comboNum)
	self._comboNum:SetText(tostring(comboNum))
	settimer(0.6, self._fadeOutFinishCallBack, self, false)
end

function SxGameCombo:_fadeOutFinishCallBack()
	removetimer(self._fadeOutFinishCallBack, self)
	goutil.destroy(self._container.gameObject)
end

return SxGameCombo
