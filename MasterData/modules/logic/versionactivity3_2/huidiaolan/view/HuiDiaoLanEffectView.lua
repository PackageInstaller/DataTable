-- chunkname: @modules/logic/versionactivity3_2/huidiaolan/view/HuiDiaoLanEffectView.lua

module("modules.logic.versionactivity3_2.huidiaolan.view.HuiDiaoLanEffectView", package.seeall)

local HuiDiaoLanEffectView = class("HuiDiaoLanEffectView", BaseView)

function HuiDiaoLanEffectView:onInitView()
	self._goFlyItemContent = gohelper.findChild(self.viewGO, "root/planeRoot/#go_plane/#go_flyItemContent")
	self._goFlyItem = gohelper.findChild(self.viewGO, "root/planeRoot/#go_plane/#go_flyItemContent/#go_flyItem")
	self._goSkillPointTarget = gohelper.findChild(self.viewGO, "root/#go_skillPointTarget")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HuiDiaoLanEffectView:addEvents()
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.onScreenResize, self)
end

function HuiDiaoLanEffectView:removeEvents()
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.onScreenResize, self)
end

function HuiDiaoLanEffectView:_editableInitView()
	self.flyEffectItemList = self:getUserDataTb_()
	self.flyEffectInitCount = 6

	gohelper.setActive(self._goFlyItem, false)

	self.skillPointNumAnim = gohelper.findChild(self.viewGO, "root/skill/skillPoint"):GetComponent(gohelper.Type_Animator)
	self.remainStepAnim = gohelper.findChild(self.viewGO, "root/info/remain"):GetComponent(gohelper.Type_Animator)
	self.goRemainNumAnim = gohelper.findChild(self.viewGO, "root/info/remain/#num")
	self.txtRemainNumCost = gohelper.findChildText(self.viewGO, "root/info/remain/#num/num")
	self.changeColorAnim = gohelper.findChild(self.viewGO, "root/skill/changeColor"):GetComponent(gohelper.Type_Animator)
	self.exchangePosAnim = gohelper.findChild(self.viewGO, "root/skill/exchangePos"):GetComponent(gohelper.Type_Animator)
	self.targetAnim = gohelper.findChild(self.viewGO, "root/info/target"):GetComponent(gohelper.Type_Animator)
end

function HuiDiaoLanEffectView:onScreenResize()
	local skillPointTargetPos = recthelper.rectToRelativeAnchorPos(self._goSkillPointTarget.transform.position, self._goFlyItemContent.transform)

	self.skillPointTargetPosX = skillPointTargetPos.x + self.planeWidth / 2
	self.skillPointTargetPosY = skillPointTargetPos.y - self.planeHeight / 2
end

function HuiDiaoLanEffectView:onUpdateParam()
	return
end

function HuiDiaoLanEffectView:onOpenFinish()
	self.gameInfoData = HuiDiaoLanGameModel.instance:getGameInfoData()
	self.planeWidth = self.gameInfoData.planeWidth
	self.planeHeight = self.gameInfoData.planeHeight
	self.planeItemWidth = self.gameInfoData.planeItemWidth
	self.planeItemHeight = self.gameInfoData.planeItemHeight

	self:onScreenResize()
end

function HuiDiaoLanEffectView:onOpen()
	for i = 1, self.flyEffectInitCount do
		self:createFlyEffect()
	end
end

function HuiDiaoLanEffectView:createFlyEffect()
	local flyEffectItem = {}

	flyEffectItem.go = gohelper.clone(self._goFlyItem, self._goFlyItemContent)
	flyEffectItem.compGO = gohelper.findChild(flyEffectItem.go, "#fly")
	flyEffectItem.comp = flyEffectItem.compGO:GetComponent(typeof(UnityEngine.UI.UIFlying))
	flyEffectItem.flyGO = gohelper.findChild(flyEffectItem.go, "fly_item")
	flyEffectItem.isActive = false

	flyEffectItem.comp:SetFlyItemObj(flyEffectItem.flyGO)
	table.insert(self.flyEffectItemList, flyEffectItem)
end

function HuiDiaoLanEffectView:getFlyEffectItem()
	for i = 1, #self.flyEffectItemList do
		if not self.flyEffectItemList[i].isActive then
			self.flyEffectItemList[i].isActive = true

			return self.flyEffectItemList[i]
		end
	end

	self:createFlyEffect()

	return self.flyEffectItemList[#self.flyEffectItemList]
end

function HuiDiaoLanEffectView:recycleFlyEffectItem(flyEffectItem)
	flyEffectItem.isActive = false

	gohelper.setActive(flyEffectItem.go, false)
	gohelper.setActive(flyEffectItem.compGO, false)
end

function HuiDiaoLanEffectView:recycleAllFlyEffectItem()
	for i = 1, #self.flyEffectItemList do
		self.flyEffectItemList[i].isActive = false

		gohelper.setActive(self.flyEffectItemList[i].compGO, false)
		gohelper.setActive(self.flyEffectItemList[i].go, false)
	end
end

function HuiDiaoLanEffectView:playEffectFlying(posIndex)
	local flyEffectItem = self:getFlyEffectItem()

	gohelper.setActive(flyEffectItem.go, true)

	local curPosX, curPosY = HuiDiaoLanGameModel.instance:getPlaneItemAnchorPos(posIndex)

	flyEffectItem.comp:SetOneFlyItemDoneAndRecycleDoneCallback(self.onFlyDone, self, flyEffectItem)

	flyEffectItem.comp.startPosition = Vector2(curPosX, curPosY)
	flyEffectItem.comp.endPosition = Vector2(self.skillPointTargetPosX, self.skillPointTargetPosY)

	gohelper.setActive(flyEffectItem.compGO, true)
	flyEffectItem.comp:StartFlying()
end

function HuiDiaoLanEffectView:onFlyDone(flyEffectItem)
	self:recycleFlyEffectItem(flyEffectItem)
end

function HuiDiaoLanEffectView:playSkillPointAnim()
	self.skillPointNumAnim:Play("fly", 0, 0)
	self.skillPointNumAnim:Update(0)
end

function HuiDiaoLanEffectView:playRemainStepAnim(animName)
	self.remainStepAnim:Play(animName, 0, 0)
	self.remainStepAnim:Update(0)
end

function HuiDiaoLanEffectView:playRemainStepCostAnim()
	gohelper.setActive(self.goRemainNumAnim, false)
	gohelper.setActive(self.goRemainNumAnim, true)

	self.txtRemainNumCost.text = "-1"
end

function HuiDiaoLanEffectView:playChangeColorSkillErrorAnim()
	self.changeColorAnim:Play("error", 0, 0)
	self.changeColorAnim:Update(0)
	GameFacade.showToast(ToastEnum.HuiDiaoLanChangeColorSkillError)
end

function HuiDiaoLanEffectView:playExchangePosSkillErrorAnim()
	self.exchangePosAnim:Play("error", 0, 0)
	self.exchangePosAnim:Update(0)
	GameFacade.showToast(ToastEnum.HuiDiaoLanExChangePosSkillError)
end

function HuiDiaoLanEffectView:playDiamondAddAnim()
	self.targetAnim:Play("fly", 0, 0)
	self.targetAnim:Update(0)
end

function HuiDiaoLanEffectView:onClose()
	self:recycleAllFlyEffectItem()
end

function HuiDiaoLanEffectView:onDestroyView()
	return
end

return HuiDiaoLanEffectView
