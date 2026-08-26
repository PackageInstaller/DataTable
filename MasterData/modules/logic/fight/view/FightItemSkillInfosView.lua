-- chunkname: @modules/logic/fight/view/FightItemSkillInfosView.lua

module("modules.logic.fight.view.FightItemSkillInfosView", package.seeall)

local FightItemSkillInfosView = class("FightItemSkillInfosView", FightBaseView)

function FightItemSkillInfosView:onInitView()
	local itemObj = gohelper.findChild(self.viewGO, "Root/#go_panel/simage_wheel/go_itemLayout/go_skillitem")

	self.itemObjList = {}

	for i = 1, 8 do
		local root = gohelper.findChild(self.viewGO, "Root/#go_panel/simage_wheel/go_itemLayout/" .. i)
		local obj = gohelper.clone(itemObj, root, "item")

		recthelper.setAnchor(obj.transform, 0, 0)
		table.insert(self.itemObjList, obj)
	end

	gohelper.setActive(itemObj, false)

	self.arrowObj = gohelper.findChild(self.viewGO, "Root/#go_panel/simage_wheel/arrow")
	self.arrowTransform = gohelper.findChild(self.viewGO, "Root/#go_panel/simage_wheel/arrow/select").transform
	self.click = gohelper.findChildClick(self.viewGO, "Root/#go_panel/simage_wheel/#btn_select")
	self.closeClick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "Root/#go_panel/#btn_close")
	self.itemName = gohelper.findChildText(self.viewGO, "Root/#go_panel/Image_skillBG/#txt_skillTitle")
	self.itemDesc = gohelper.findChildText(self.viewGO, "Root/#go_panel/Image_skillBG/#txt_skillDec")
end

function FightItemSkillInfosView:addEvents()
	self.tweenComp = self:addComponent(FightTweenComponent)

	self:com_registClick(self.click, self.onClick)
	self:com_registClick(self.closeClick, self.closeThis)
	self:com_registFightEvent(FightEvent.StageChanged, self.onStageChanged)
	self:com_registFightEvent(FightEvent.RespUseClothSkillFail, self.onRespUseClothSkillFail)
end

function FightItemSkillInfosView:removeEvents()
	return
end

function FightItemSkillInfosView:onStageChanged()
	self:closeThis()
end

function FightItemSkillInfosView:onRespUseClothSkillFail()
	self:closeThis()
end

function FightItemSkillInfosView:onClick()
	if not self.selectData then
		return
	end

	if self.selectData.cd > 0 then
		GameFacade.showToast(ToastEnum.Season123RefreshAssistInCD)

		return
	end

	if self.selectData.count <= 0 then
		GameFacade.showToast(ToastEnum.DungeonMapLevel4)

		return
	end

	gohelper.setActive(self.arrowObj, false)

	for i = 1, #self.itemObjList do
		local obj = self.itemObjList[i]

		gohelper.setActive(obj, i == self.selectIndex)
	end

	local flow = self:com_registFlowSequence()
	local parallel = flow:registWork(FightWorkFlowParallel)
	local transform = self.itemObjList[self.selectIndex].transform
	local offsetX, offsetY = recthelper.getAnchor(transform.parent)
	local ease = EaseType.OutQuart
	local tweenData = {
		type = "DOAnchorPos",
		t = 0.2,
		tr = self.itemObjList[self.selectIndex].transform,
		tox = -offsetX,
		toy = -offsetY,
		ease = ease
	}

	parallel:registWork(FightTweenWork, tweenData)
	parallel:registWork(FightWorkPlayAnimator, self.viewGO, "close")

	tweenData = {
		from = 1,
		type = "DOFadeCanvasGroup",
		to = 0,
		t = 0.2,
		go = transform.gameObject
	}

	flow:registWork(FightTweenWork, tweenData)
	flow:registWork(FightWorkFunction, self.sendMsg, self)
	flow:start()
	AudioMgr.instance:trigger(20305003)
end

function FightItemSkillInfosView:sendMsg()
	FightRpc.instance:sendUseClothSkillRequest(self.selectData.skillId, "0", FightDataHelper.operationDataMgr.curSelectEntityId, FightEnum.ClothSkillType.AssassinBigSkill)
end

function FightItemSkillInfosView:onItemClick(data, index)
	if self.selectData == data then
		self:onClick()

		return
	end

	self.selectData = data
	self.selectIndex = index

	local itemConfig = lua_assassin_item.configDict[data.itemId]

	self.itemName.text = itemConfig.name
	self.itemDesc.text = HeroSkillModel.instance:skillDesToSpot(itemConfig.fightEffDesc, "#c56131", "#7c93ad")

	local localPos = self.itemObjList[index].transform.parent.localPosition
	local direction = localPos.normalized
	local angle = Mathf.Atan2(direction.y, direction.x) * Mathf.Rad2Deg

	angle = angle - 180

	local duration = 0.35
	local ease = EaseType.OutQuart

	self.tweenComp:DOLocalRotate(self.arrowTransform, 0, 0, angle, duration, nil, nil, nil, ease)

	for i, itemView in ipairs(self.itemList) do
		itemView:onSelect(i == index)
	end

	AudioMgr.instance:trigger(20305002)
end

function FightItemSkillInfosView:onOpen()
	AudioMgr.instance:trigger(20305001)

	self.itemList = {}

	local itemSkillInfos = FightDataHelper.teamDataMgr.myData.itemSkillInfos

	table.sort(itemSkillInfos, function(a, b)
		return a.itemId < b.itemId
	end)

	for i = 1, #self.itemObjList do
		local obj = self.itemObjList[i]
		local data = itemSkillInfos[i]

		if data then
			local itemView = self:com_openSubView(FightItemSkillInfosItemView, obj, nil, data, i)

			table.insert(self.itemList, itemView)
		else
			gohelper.setActive(obj, false)
		end
	end

	local clicked = false

	for i = 1, #itemSkillInfos do
		local data = itemSkillInfos[i]

		if data.cd <= 0 and data.count > 0 then
			self.itemList[i]:onClick()

			clicked = true

			break
		end
	end

	if not clicked then
		self.itemList[1]:onClick()
	end

	AudioMgr.instance:trigger(20305002)
end

return FightItemSkillInfosView
