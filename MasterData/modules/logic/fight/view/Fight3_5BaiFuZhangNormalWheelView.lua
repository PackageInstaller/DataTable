-- chunkname: @modules/logic/fight/view/Fight3_5BaiFuZhangNormalWheelView.lua

module("modules.logic.fight.view.Fight3_5BaiFuZhangNormalWheelView", package.seeall)

local Fight3_5BaiFuZhangNormalWheelView = class("Fight3_5BaiFuZhangNormalWheelView", FightBaseView)

function Fight3_5BaiFuZhangNormalWheelView:onInitView()
	self.cardItem = gohelper.findChild(self.viewGO, "wheel/card/go_carditem")
	self.wheelRoot = gohelper.findChild(self.viewGO, "wheel").transform
	self.pointer = gohelper.findChild(self.viewGO, "#zhizhen").transform
	self.rootAnimator = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))
	self.selectRoot = gohelper.findChild(self.viewGO, "Right/layout")
	self.selectItem = gohelper.findChild(self.viewGO, "Right/layout/go_item")
	self.pointerCanvas = gohelper.findChildComponent(self.viewGO, "#zhizhen/glow", gohelper.Type_CanvasGroup)
end

function Fight3_5BaiFuZhangNormalWheelView:addEvents()
	return
end

function Fight3_5BaiFuZhangNormalWheelView:removeEvents()
	return
end

function Fight3_5BaiFuZhangNormalWheelView:initWheelData()
	local randomList = {
		{
			1,
			0,
			1,
			0,
			1,
			0
		},
		{
			0,
			0,
			1,
			0,
			0,
			1
		},
		{
			1,
			1,
			0,
			0,
			1,
			0
		}
	}
	local randomNum = math.random(1, 10)
	local index = 1

	index = randomNum <= 2 and 1 or randomNum <= 5 and 2 or 3

	local startIndex = math.random(1, 6)
	local dataList = randomList[index]

	for i = startIndex - 1, 1, -1 do
		table.insert(dataList, table.remove(dataList, 1))
	end

	self.wheelData = dataList
end

function Fight3_5BaiFuZhangNormalWheelView:onWheelRotate(value)
	local rotate = value % 360

	transformhelper.setLocalRotation(self.wheelRoot, 0, 0, rotate)
end

function Fight3_5BaiFuZhangNormalWheelView:onOpen()
	self.tweenComp = self:addComponent(FightTweenComponent)
	self.selectStage = 1

	gohelper.setActive(self.cardItem, true)

	local flow = self:com_registFlowSequence()

	flow:registWork(FightWorkDelayTimer)

	self.wheelData = FightDataHelper.baiFuZhangWheelDataMgr.wheelData
	self.index = FightDataHelper.baiFuZhangWheelDataMgr.index

	if not self.wheelData then
		self.isInit = true

		self:initWheelData()

		self.index = 1
		FightDataHelper.baiFuZhangWheelDataMgr.wheelData = self.wheelData
		FightDataHelper.baiFuZhangWheelDataMgr.index = 1
	end

	self:showWheelList()

	if self.isInit then
		AudioMgr.instance:trigger(350042)
		flow:registWork(FightWorkDelayTimer, 1.2)
		flow:registWork(FightWorkFunction, AudioMgr.instance.trigger, AudioMgr.instance, 20002201)

		self.wheelRotate = 300

		transformhelper.setLocalRotation(self.wheelRoot, 0, 0, self.wheelRotate)

		local ease = EaseType.OutCubic
		local time = 2

		flow:registWork(FightTweenWork, {
			type = "DOTweenFloat",
			to = 0,
			from = self.wheelRotate,
			t = time,
			frameCb = self.onWheelRotate,
			cbObj = self,
			ease = ease
		})
		flow:registWork(FightWorkDelayTimer, 0.16)
		transformhelper.setLocalRotation(self.pointer, 0, 0, 0)
	else
		transformhelper.setLocalRotation(self.pointer, 0, 0, -self.index * 60 + 60)

		self.index = self.index % 6 + 1
		FightDataHelper.baiFuZhangWheelDataMgr.index = self.index

		while FightDataHelper.baiFuZhangWheelDataMgr.selectedIndex[self.index] do
			self.index = self.index % 6 + 1
			FightDataHelper.baiFuZhangWheelDataMgr.index = self.index
		end
	end

	flow:registWork(FightWorkFunction, self.showSelectItem, self)
	flow:registWork(FightWorkPlayAnimator, self.rootAnimator.gameObject, "move")

	local parallelFlow = flow:registWork(FightWorkFlowParallel)

	if not self.isInit then
		parallelFlow:registWork(FightWorkFunction, AudioMgr.instance.trigger, AudioMgr.instance, 350036)
	end

	parallelFlow:registWork(FightTweenWork, {
		type = "DOLocalRotate",
		tox = 0,
		toy = 0,
		t = 0.3,
		tr = self.pointer,
		toz = -self.index * 60 + 60
	})
	flow:registFinishCallback(self.onflowFinish, self)
	flow:start()
end

function Fight3_5BaiFuZhangNormalWheelView:showSelectItem()
	self.clickDataList = {}

	self:com_createObjList(self.onSelectItemShow, {
		1,
		2,
		3
	}, self.selectRoot, self.selectItem)
end

function Fight3_5BaiFuZhangNormalWheelView:onSelectItemShow(obj, data, index)
	local selectObj = gohelper.findChild(obj, "select")
	local unSelectObj = gohelper.findChild(obj, "unselect")

	gohelper.setActive(selectObj, false)
	gohelper.setActive(unSelectObj, true)

	local useObj = gohelper.findChild(obj, "unselect/use")
	local noUseObj = gohelper.findChild(obj, "unselect/notuse")
	local selectUseObj = gohelper.findChild(obj, "select/use")
	local selectNoUseObj = gohelper.findChild(obj, "select/notuse")
	local titleStr = ""

	if index == 1 then
		titleStr = luaLang("fight_bai_fu_zhang_wheel_1")

		gohelper.setActive(useObj, true)
		gohelper.setActive(noUseObj, false)
		gohelper.setActive(selectUseObj, true)
		gohelper.setActive(selectNoUseObj, false)
	elseif index == 2 then
		titleStr = luaLang("fight_bai_fu_zhang_wheel_3")

		gohelper.setActive(useObj, true)
		gohelper.setActive(noUseObj, false)
		gohelper.setActive(selectUseObj, true)
		gohelper.setActive(selectNoUseObj, false)
	elseif index == 3 then
		gohelper.setActive(useObj, false)
		gohelper.setActive(noUseObj, true)
		gohelper.setActive(selectUseObj, false)
		gohelper.setActive(selectNoUseObj, true)
	end

	local text = gohelper.findChildText(obj, "unselect/use/#txt_title")

	text.text = titleStr
	text = gohelper.findChildText(obj, "select/use/#txt_title")
	text.text = titleStr

	local descStr = ""

	if index == 1 then
		descStr = luaLang("fight_bai_fu_zhang_wheel_2")
	elseif index == 2 then
		descStr = luaLang("fight_bai_fu_zhang_wheel_4")
	end

	text = gohelper.findChildText(obj, "unselect/use/#txt_desc")
	text.text = descStr
	text = gohelper.findChildText(obj, "select/use/#txt_desc")
	text.text = descStr

	local click = gohelper.getClickWithDefaultAudio(obj)
	local clickData = {
		obj = obj,
		index = index,
		selectObj = selectObj,
		unSelectObj = unSelectObj
	}

	table.insert(self.clickDataList, clickData)
	self:com_registClick(click, self.onClickSelectItem, clickData)
end

function Fight3_5BaiFuZhangNormalWheelView:onClickSelectItem(clickData)
	if self.selectStage == 2 then
		return
	end

	local obj = clickData.obj
	local index = clickData.index

	if self.selectIndex == index then
		local btnAnimator = gohelper.findChildComponent(obj, "select", typeof(UnityEngine.Animator))

		btnAnimator:Play("confirm", 0, 0)
		AudioMgr.instance:trigger(350038)

		self.selectStage = 2

		if index == 1 then
			self.index = self.index % 6 + 1
			FightDataHelper.baiFuZhangWheelDataMgr.index = self.index

			while FightDataHelper.baiFuZhangWheelDataMgr.selectedIndex[self.index] do
				self.index = self.index % 6 + 1
				FightDataHelper.baiFuZhangWheelDataMgr.index = self.index
			end

			AudioMgr.instance:trigger(350036)
			self.tweenComp:DOLocalRotate(self.pointer, 0, 0, -self.index * 60 + 60, 0.3, self.onPointerForward, self)

			return
		elseif index == 2 then
			local wheelId = self.wheelData[self.index] == 0 and 1 or 0
			local viewData = {
				isPlus = true,
				isSwitch = true,
				wheelId = wheelId
			}

			self.cardAnimatorList[self.index]:Play("select", 0, 0)
			self:com_registTimer(self.delayOpenView, 0.6, viewData)

			return
		end

		local viewData = {
			isPlus = false,
			isSpecial = true,
			wheelId = self.wheelData[self.index]
		}

		ViewMgr.instance:openView(ViewName.Fight3_5BaiFuZhangWheelSelectCardView, viewData)

		return
	end

	if self.lastClickData then
		gohelper.setActive(self.lastClickData.selectObj, false)
		gohelper.setActive(self.lastClickData.unSelectObj, true)
		gohelper.setActiveCanvasGroupNoAnchor(self.pointerCanvas, false)
	end

	self.selectIndex = index

	if index == 1 then
		gohelper.setActiveCanvasGroupNoAnchor(self.pointerCanvas, true)
	end

	self.lastClickData = clickData

	gohelper.setActive(clickData.selectObj, true)
	gohelper.setActive(clickData.unSelectObj, false)
end

function Fight3_5BaiFuZhangNormalWheelView:delayOpenView(viewData)
	ViewMgr.instance:openView(ViewName.Fight3_5BaiFuZhangWheelSelectCardView, viewData)
end

function Fight3_5BaiFuZhangNormalWheelView:onPointerForward()
	local viewData = {
		isPlus = true,
		isSpecial = true,
		wheelId = self.wheelData[self.index]
	}

	self.cardAnimatorList[self.index]:Play("select", 0, 0)
	self:com_registTimer(self.delayOpenView, 0.6, viewData)
end

function Fight3_5BaiFuZhangNormalWheelView:onflowFinish()
	if FightDataHelper.stateMgr:getIsAuto() then
		self:com_registTimer(self.autoSelect, 5)
	end
end

function Fight3_5BaiFuZhangNormalWheelView:autoSelect()
	self:onClickSelectItem(self.clickDataList[3])
	self:onClickSelectItem(self.clickDataList[3])
end

function Fight3_5BaiFuZhangNormalWheelView:showWheelList()
	self.cardAnimatorList = {}

	for i = 1, 6 do
		local cardRoot = gohelper.findChild(self.viewGO, string.format("wheel/card/pos%d", i))
		local cardItem = gohelper.clone(self.cardItem, cardRoot)
		local cardIcon = gohelper.findChildSingleImage(cardItem, "root/#card")
		local cardName = self.wheelData[i] == 1 and "103005" or "760021"

		cardName = ResUrl.getSkillIcon(cardName)

		cardIcon:LoadImage(cardName)

		local animator = gohelper.onceAddComponent(cardItem, typeof(UnityEngine.Animator))

		table.insert(self.cardAnimatorList, animator)

		if self.isInit then
			animator:Play("open", 0, 0)
		elseif FightDataHelper.baiFuZhangWheelDataMgr.selectedIndex[i] then
			animator:Play("idle_card", 0, 0)
		else
			animator:Play("idle_black", 0, 0)
		end
	end

	gohelper.setActive(self.cardItem, false)
end

function Fight3_5BaiFuZhangNormalWheelView:onClose()
	return
end

function Fight3_5BaiFuZhangNormalWheelView:onDestroyView()
	return
end

return Fight3_5BaiFuZhangNormalWheelView
