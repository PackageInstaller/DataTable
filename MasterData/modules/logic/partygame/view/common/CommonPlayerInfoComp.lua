-- chunkname: @modules/logic/partygame/view/common/CommonPlayerInfoComp.lua

module("modules.logic.partygame.view.common.CommonPlayerInfoComp", package.seeall)

local CommonPlayerInfoComp = class("CommonPlayerInfoComp", ListScrollCellExtend)

function CommonPlayerInfoComp:onInitView()
	self._txtaddscore = gohelper.findChildText(self.viewGO, "#txt_addscore")
	self._txtsubscore = gohelper.findChildText(self.viewGO, "#txt_subscore")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._gomainPlayer = gohelper.findChild(self.viewGO, "#go_mainPlayer")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommonPlayerInfoComp:addEvents()
	return
end

function CommonPlayerInfoComp:removeEvents()
	return
end

function CommonPlayerInfoComp:_editableInitView()
	self._goAddScore = self._txtaddscore.gameObject
	self._goSubScore = self._txtsubscore.gameObject
	self._goName = self._txtname.gameObject

	gohelper.setActive(self._goAddScore, false)
	gohelper.setActive(self._goSubScore, false)
	gohelper.setActive(self._goName, false)
	gohelper.setActive(self._gomainPlayer, false)

	self._uiFollower = gohelper.onceAddComponent(self.viewGO, typeof(ZProj.UIFollower))
end

function CommonPlayerInfoComp:_editableAddEvents()
	return
end

function CommonPlayerInfoComp:_editableRemoveEvents()
	return
end

local TweenHelper = ZProj.TweenHelper
local moveTime = 1

function CommonPlayerInfoComp:initPlayerMo(playerMo)
	self._playerMo = playerMo

	if self._playerMo == nil then
		return
	end

	self:initView()

	self._allTweens = {}
end

function CommonPlayerInfoComp:initView()
	self._txtname.text = self._playerMo:getColorName()

	gohelper.setActive(self._gomainPlayer, self._playerMo:isMainPlayer())
	gohelper.setActive(self._goName, not self._playerMo:isMainPlayer())

	local trans = PartyGame.Runtime.GameLogic.GameInterfaceBase.GetPlayerTransform(self._playerMo.uid)
	local head = gohelper.findChild(trans.gameObject, "head")
	local mainCamera = CameraMgr.instance:getMainCamera()
	local uiCamera = CameraMgr.instance:getUICamera()
	local plane = ViewMgr.instance:getUIRoot().transform

	self._uiFollower:Set(mainCamera, uiCamera, plane, head.transform, 0, 0, 0, 0, 0)
	self._uiFollower:SetBillboardRoot(trans)
	self._uiFollower:SetUseBillboard(true)
	self._uiFollower:SetEnable(true)
end

function CommonPlayerInfoComp:showScoreDiff(scoreDiff)
	if not self._playerMo:isMainPlayer() then
		return
	end

	local cloneGo = gohelper.clone((scoreDiff < 0 or nil) and self._goSubScore, self.viewGO)
	local scoreTxt = cloneGo:GetComponent(gohelper.Type_Text)

	scoreTxt.text = scoreDiff < 0 and tostring(scoreDiff) or "+" .. scoreDiff

	gohelper.setActive(cloneGo, true)

	local tween1 = TweenHelper.DOAnchorPosY(cloneGo.transform, 20, moveTime, self.releaseGo, self, cloneGo)

	table.insert(self._allTweens, tween1)
end

function CommonPlayerInfoComp:releaseGo(go)
	if gohelper.isNil(go) then
		return
	end

	gohelper.destroy(go)
end

function CommonPlayerInfoComp:onDestroyView()
	for i = 1, #self._allTweens do
		local tweenId = self._allTweens[i]

		TweenHelper.KillById(tweenId)
	end
end

return CommonPlayerInfoComp
