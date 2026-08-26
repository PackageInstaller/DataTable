-- chunkname: @modules/logic/versionactivity3_0/karong/view/comp/KaRongDrawObjAlert.lua

module("modules.logic.versionactivity3_0.karong.view.comp.KaRongDrawObjAlert", package.seeall)

local KaRongDrawObjAlert = class("KaRongDrawObjAlert", UserDataDispose)

function KaRongDrawObjAlert:ctor(go)
	self:__onInit()

	self.go = go
	self.image = gohelper.findChildImage(self.go, "#image_content")
	self.imageTf = self.image.transform
	self.tf = self.go.transform

	UISpriteSetMgr.instance:setPuzzleSprite(self.image, KaRongDrawEnum.MazeAlertResPath, true)
end

function KaRongDrawObjAlert:onInit(mo, posX, posY)
	self.mo = mo
end

function KaRongDrawObjAlert:onEnable(alertType, alertObj)
	gohelper.setActive(self.go, true)
	gohelper.setAsLastSibling(self.go)

	local linePos = string.splitToNumber(alertObj, "_")

	if alertType == KaRongDrawEnum.MazeAlertType.VisitBlock or alertType == KaRongDrawEnum.MazeAlertType.DisconnectLine then
		local anchorX, anchorY = KaRongDrawModel.instance:getLineAnchor(linePos[1], linePos[2], linePos[3], linePos[4])

		recthelper.setAnchor(self.tf, anchorX + KaRongDrawEnum.MazeAlertBlockOffsetX, anchorY + KaRongDrawEnum.MazeAlertBlockOffsetY)
	elseif alertType == KaRongDrawEnum.MazeAlertType.VisitRepeat then
		local anchorX, anchorY = KaRongDrawModel.instance:getObjectAnchor(linePos[1], linePos[2])

		recthelper.setAnchor(self.tf, anchorX + KaRongDrawEnum.MazeAlertCrossOffsetX, anchorY + KaRongDrawEnum.MazeAlertCrossOffsetY)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Act176_ForbiddenGo)
end

function KaRongDrawObjAlert:onDisable()
	gohelper.setActive(self.go, false)
end

function KaRongDrawObjAlert:destroy()
	self:__onDispose()
end

return KaRongDrawObjAlert
