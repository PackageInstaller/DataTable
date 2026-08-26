-- chunkname: @modules/logic/survival/view/shelter/SummaryAct/SurvivalSummaryNpcHUD.lua

module("modules.logic.survival.view.shelter.SummaryAct.SurvivalSummaryNpcHUD", package.seeall)

local SurvivalSummaryNpcHUD = class("SurvivalSummaryNpcHUD", LuaCompBase)

function SurvivalSummaryNpcHUD:ctor(entityGO)
	self.entityGO = entityGO
end

function SurvivalSummaryNpcHUD:init(viewGO)
	self.viewGO = viewGO
	self._animroot = gohelper.findChildAnim(self.viewGO, "root")
	self._imagebubble = gohelper.findChildImage(self.viewGO, "root/#image_bubble")
	self._imageicon = gohelper.findChildImage(self.viewGO, "root/#image_icon")
	self._goInfo = gohelper.findChild(self.viewGO, "root/#go_Info")
	self._animgoinfo = self._goInfo:GetComponent(gohelper.Type_Animation)
	self._txtInfo = gohelper.findChildText(self.viewGO, "root/#go_Info/Info/#txt_Info")
	self._imagelevel = gohelper.findChildImage(self.viewGO, "root/#go_Info/Info/#txt_Info/#image_level")
	self._goreddot = gohelper.findChild(self.viewGO, "root/#go_Info/Info/#txt_Info/#go_reddot")
	self._txtadd = gohelper.findChildText(self.viewGO, "root/#go_Info/Info/#txt_Info/#txt_add")
	self.txt_name = gohelper.findChildText(self.viewGO, "root/#go_Info/#txt_name")
	self.trans = viewGO.transform

	transformhelper.setLocalPos(self.trans, 9999, 9999, 0)

	local mainCamera = CameraMgr.instance:getMainCamera()
	local uiCamera = CameraMgr.instance:getUICamera()
	local plane = ViewMgr.instance:getUIRoot().transform

	gohelper.setActive(self._goarrow, false)

	self._uiFollower = gohelper.onceAddComponent(self.viewGO, typeof(ZProj.UIFollower))

	self._uiFollower:Set(mainCamera, uiCamera, plane, self.entityGO.transform, 0, 1.1, 0, 0, 0)
	self._uiFollower:SetEnable(true)
end

function SurvivalSummaryNpcHUD:addEventListeners()
	return
end

function SurvivalSummaryNpcHUD:removeEventListeners()
	return
end

function SurvivalSummaryNpcHUD:playCloseAnim()
	self._animroot:Play(UIAnimationName.Close)
end

function SurvivalSummaryNpcHUD:onDestroy()
	if self.textTweenId then
		ZProj.TweenHelper.KillById(self.textTweenId)

		self.textTweenId = nil
	end
end

function SurvivalSummaryNpcHUD:setData(npcId, upInfo)
	self.npcId = npcId
	self.upInfo = upInfo
	self.npcCfg = SurvivalConfig.instance:getNpcConfig(self.npcId)
	self.txt_name.text = self.npcCfg.name
end

return SurvivalSummaryNpcHUD
