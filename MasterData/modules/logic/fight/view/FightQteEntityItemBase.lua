-- chunkname: @modules/logic/fight/view/FightQteEntityItemBase.lua

module("modules.logic.fight.view.FightQteEntityItemBase", package.seeall)

local FightQteEntityItemBase = class("FightQteEntityItemBase", UserDataDispose)

FightQteEntityItemBase.UseType = {
	QTETip = 2,
	QTEBtn = 1,
	QTEUnique = 3
}
FightQteEntityItemBase.Stage = {
	Special = 3,
	CanUse = 2,
	CantUse = 1
}
FightQteEntityItemBase.Stage2Anim = {
	[FightQteEntityItemBase.Stage.CantUse] = "gray",
	[FightQteEntityItemBase.Stage.CanUse] = "stage1",
	[FightQteEntityItemBase.Stage.Special] = "stage2"
}

function FightQteEntityItemBase:init(entityMo, useType)
	self:__onInit()

	self.entityMo = entityMo
	self.entityId = entityMo.uid
	self.useType = useType
	self.qteGroupCo = self.entityMo:getQteGroupCo()
	self.activeSkillId = self.qteGroupCo and self.qteGroupCo.activeId
	self.preCost = 0
	self.loadedDone = false
end

function FightQteEntityItemBase:setPrefabPath(prefabPath)
	self.prefabPath = prefabPath
end

function FightQteEntityItemBase:startLoad()
	if self.loader then
		return
	end

	if string.nilorempty(self.prefabPath) then
		logError("资源路径不存在")

		return
	end

	self.loader = MultiAbLoader.New()

	self.loader:addPath(self.prefabPath)
	self.loader:startLoad(self.onLoadCallback, self)
end

function FightQteEntityItemBase:onLoadCallback()
	local assetItem = self.loader:getFirstAssetItem()
	local prefab = assetItem:GetResource()

	self.viewGo = gohelper.clone(prefab, self.parent)
	self.viewRectTr = self.viewGo:GetComponent(gohelper.Type_RectTransform)

	recthelper.setAnchor(self.viewRectTr, 0, 0)
	self:initView()
	self:refreshUI()
	self:addEvents()
end

function FightQteEntityItemBase:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.QTE_OnUpdate, self.refreshUI, self)
end

local LongPressArr = {
	0.5,
	99999
}

function FightQteEntityItemBase:initView()
	self.viewAnimator = self.viewGo:GetComponent(gohelper.Type_Animator)
	self.goClickEffect = gohelper.findChild(self.viewGo, "root/click_effect")

	gohelper.setActive(self.goClickEffect, false)

	self.goCanClick = gohelper.findChild(self.viewGo, "root/#go_canclick")
	self.btnClick = gohelper.findChildClick(self.viewGo, "root/#btn_click")

	self.addClickCb(self, self.btnClick, self.onClickThis, self)

	self.longPress = SLFramework.UGUI.UILongPressListener.GetWithPath(self.viewGo, "root/#btn_click")

	self.longPress:SetLongPressTime(LongPressArr)
	self.longPress:AddLongPressListener(self.onLongPress, self)

	self.headIcon = gohelper.findChildSingleImage(self.viewGo, "root/image_hero")
	self.goNum = gohelper.findChild(self.viewGo, "root/num")
	self.numAnimator = self.goNum:GetComponent(gohelper.Type_Animator)
	self.goCanUse = gohelper.findChild(self.goNum, "#go_canuse")
	self.imageCostType = gohelper.findChildImage(self.goNum, "image_numbg")
	self.txtCost = gohelper.findChildText(self.goNum, "#txt_num")
	self.txtCostEffect = gohelper.findChildText(self.goNum, "#txt_num_effect")
	self.goSkill = gohelper.findChild(self.viewGo, "root/skill")
	self.simageIcon = gohelper.findChildSingleImage(self.goSkill, "mask/simage_skillcard")
	self.loadedDone = true

	self:refreshHeadIcon()
	self:refreshSkill()
end

function FightQteEntityItemBase:refreshUI()
	if not self.loadedDone then
		return
	end

	self:refreshCost()
	self:refreshCanUse()
	self:refreshStageAnim()
end

function FightQteEntityItemBase:refreshStageAnim()
	local stage = self:getStage()
	local anim = FightQteEntityItemBase.Stage2Anim[stage]

	self.viewAnimator:Play(anim)
end

function FightQteEntityItemBase:getStage()
	local qteInfo = FightDataHelper.qteDataMgr:getQteInfo()

	if not qteInfo then
		return FightQteEntityItemBase.Stage.CantUse
	end

	local costType, cost = self:getCostTypeAndCost()
	local count = qteInfo:getEnergyCount(costType)

	if count < cost then
		return FightQteEntityItemBase.Stage.CantUse
	end

	return FightQteEntityItemBase.Stage.CanUse
end

function FightQteEntityItemBase:refreshCanClick()
	local qteInfo = FightDataHelper.qteDataMgr:getQteInfo()

	if not qteInfo then
		gohelper.setActive(self.goCanClick, false)

		return
	end

	local costType, cost = self:getCostTypeAndCost()
	local count = qteInfo:getEnergyCount(costType)

	if count < cost then
		gohelper.setActive(self.goCanClick, false)

		return
	end

	gohelper.setActive(self.goCanClick, true)
end

function FightQteEntityItemBase:refreshHeadIcon()
	local resUrl = ResUrl.getFightQteSingleBg(self.entityMo.skin)

	self.headIcon:LoadImage(resUrl)
end

function FightQteEntityItemBase:refreshCanUse()
	if not self.loadedDone then
		return
	end

	gohelper.setActive(self.goCanUse, false)
end

function FightQteEntityItemBase:refreshCost()
	if not self.loadedDone then
		return
	end

	if self.useType == FightQteEntityItemBase.UseType.QTEUnique then
		gohelper.setActive(self.goNum, false)

		return
	end

	gohelper.setActive(self.goNum, true)

	local skillCo = lua_skill.configDict[self.activeSkillId]

	if not skillCo then
		self.txtCost.text = 0
		self.txtCostEffect.text = 0
		self.preCost = 0

		return
	end

	local costType, cost = self:getCostTypeAndCost()

	self.txtCost.text = cost
	self.txtCostEffect.text = cost

	local image = FightQteEntityItemHelper.getCostTypeImage(costType)

	UISpriteSetMgr.instance:setFightSprite(self.imageCostType, image)

	if cost ~= self.preCost then
		self.preCost = cost

		self.numAnimator:Play("switch", 0, 0)
	end
end

function FightQteEntityItemBase:refreshSkill()
	if not self.loadedDone then
		return
	end

	if self.useType == FightQteEntityItemBase.UseType.QTETip then
		local skillCo = lua_skill.configDict[self.activeSkillId]

		if not skillCo then
			gohelper.setActive(self.goSkill, false)

			return
		end

		gohelper.setActive(self.goSkill, true)

		local icon = ResUrl.getSkillIcon(skillCo.icon)

		self.simageIcon:LoadImage(icon)
	else
		gohelper.setActive(self.goSkill, false)
	end
end

function FightQteEntityItemBase:getCostTypeAndCost()
	local skillCo = lua_skill.configDict[self.activeSkillId]

	if not skillCo then
		return 0, 0
	end

	local costType, cost = FightHelper.getQTESkillCost(skillCo)

	return costType, cost
end

function FightQteEntityItemBase:setIndex(index)
	self.index = index
end

function FightQteEntityItemBase:getIndex()
	return self.index
end

function FightQteEntityItemBase:setParent(parent)
	self.parent = parent

	if not self.loadedDone then
		return
	end

	gohelper.setParent(self.viewGo, self.parent)
	recthelper.setAnchor(self.viewRectTr, 0, 0)
end

function FightQteEntityItemBase:onClickThis()
	if self.useType ~= FightQteEntityItemBase.UseType.QTEBtn then
		return
	end

	if not FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.QTE) then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	local qteInfo = FightDataHelper.qteDataMgr:getQteInfo()

	if not qteInfo then
		return
	end

	local costType, cost = self:getCostTypeAndCost()
	local count = qteInfo:getEnergyCount(costType)

	if count < cost then
		return
	end

	gohelper.setActive(self.goClickEffect, false)
	gohelper.setActive(self.goClickEffect, true)

	local uid = self.entityMo.uid
	local curSelectEntityId = FightDataHelper.operationDataMgr.curSelectEntityId

	FightRpc.instance:sendUseQTESkillRequest(uid, curSelectEntityId)
end

function FightQteEntityItemBase:onLongPress()
	if self.useType ~= FightQteEntityItemBase.UseType.QTEBtn then
		return
	end

	if not FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.QTE) then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	ViewMgr.instance:openView(ViewName.QteSkillTipView, self.qteGroupCo.qteGoupId)
end

function FightQteEntityItemBase:dispose()
	if self.simageIcon then
		self.simageIcon:UnLoadImage()

		self.simageIcon = nil
	end

	if self.headIcon then
		self.headIcon:UnLoadImage()

		self.headIcon = nil
	end

	if self.longPress then
		self.longPress:RemoveLongPressListener()

		self.longPress = nil
	end

	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	self:__onDispose()
end

return FightQteEntityItemBase
