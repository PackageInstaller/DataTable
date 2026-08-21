-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/monument/MonumentMainView.lua

module("logic.extensions.playerinfo.view.monument.MonumentMainView", package.seeall)

local M = class("MonumentMainView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._index = 0
	self._canDrag = true
end

function M:buildUI()
	self._beginPosition = Vector2.New()
	self._btnNextPage = Astral.ButtonAdapter.Get(goutil.findChild(self.mainGO, "page_content/nextPage"))
	self._btnPreviousPage = Astral.ButtonAdapter.Get(goutil.findChild(self.mainGO, "page_content/previousPage"))

	local monumentItemGo = goutil.findChild(self.mainGO, "left/syndromeCell/syndrome_card_item")

	self._monumentItemView = Astral.LuaComponentContainer.Add(monumentItemGo, MonumentItemCell)

	self._monumentItemView:setNameVisible(false)

	self._txtTime = goutil.findChildTextComponent(self.mainGO, "left/txtTime")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "right/txtName")
	self._txtLevel = goutil.findChildTextComponent(self.mainGO, "right/txtNum")
	self._txtDesc1 = goutil.findChildTextComponent(self.mainGO, "right/txtDesc1")
	self._txtDesc2 = goutil.findChildTextComponent(self.mainGO, "right/txtDesc2")

	local txtRate1 = goutil.findChildTextComponent(self.mainGO, "right/rateLayer/layer1/txtRate")
	local txtRate2 = goutil.findChildTextComponent(self.mainGO, "right/rateLayer/layer2/txtRate")
	local txtRate3 = goutil.findChildTextComponent(self.mainGO, "right/rateLayer/layer3/txtRate")
	local txtRate4 = goutil.findChildTextComponent(self.mainGO, "right/rateLayer/layer4/txtRate")

	self._rateTxts = {
		txtRate1,
		txtRate2,
		txtRate3,
		txtRate4
	}

	local lightGo1 = goutil.findChild(self.mainGO, "right/rateLayer/layer1/light")
	local lightGo2 = goutil.findChild(self.mainGO, "right/rateLayer/layer2/light")
	local lightGo3 = goutil.findChild(self.mainGO, "right/rateLayer/layer3/light")
	local lightGo4 = goutil.findChild(self.mainGO, "right/rateLayer/layer4/light")

	self._ligthGos = {
		lightGo1,
		lightGo2,
		lightGo3,
		lightGo4
	}
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
end

function M:bindEvents()
	self._btnNextPage:AddClickListener(self._onClickNext, self)
	self._btnPreviousPage:AddClickListener(self._onClickPrevious, self)
end

function M:unbindEvents()
	self._btnNextPage:RemoveClickListener()
	self._btnPreviousPage:RemoveClickListener()
end

function M:onEnter()
	self._moList = MonumentModel.instance:getMonumentListModel():getMoList()

	local params = self:getFirstParam() or {}
	local index = params.index or 1

	self:_turnToIndex(index)
	goutil.setActive(self._btnPreviousPage.gameObject, #self._moList > 1)
	goutil.setActive(self._btnNextPage.gameObject, #self._moList > 1)
end

function M:onExit()
	return
end

function M:destroyUI()
	return
end

function M:_onClickNext()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open_right")
	self:_turnNext()
end

function M:_onClickPrevious()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open_left")
	self:_turnPrevious()
end

function M:_onBeginDrag(evt)
	self._beginPosition:Set(0, 0)
	self._beginPosition:Add(evt.position)
end

function M:_onEndDrag(evt)
	if not self._canDrag then
		return
	end

	local position = evt.position
	local deltaX = position.x - self._beginPosition.x

	if deltaX >= 10 then
		self:_turnPrevious()
	elseif deltaX <= -10 then
		self:_turnNext()
	end
end

function M:_turnToIndex(index)
	self._index = index

	local mo = self._moList[index]

	self:showMonumentInfo(mo)
end

function M:_turnNext()
	local index = self._index

	if index < #self._moList then
		index = index + 1
	else
		index = 1
	end

	self:_turnToIndex(index)
	self._monumentItemView:changeLeftRight()
end

function M:_turnPrevious()
	local index = self._index

	if index > 1 then
		index = index - 1
	else
		index = #self._moList
	end

	self:_turnToIndex(index)
	self._monumentItemView:changeLeftRight()
end

function M:showMonumentInfo(monumentMo)
	self._monumentItemView:updateData(monumentMo)
	self._txtLevel.gameObject:SetActive(true)

	local maxLevel = MonumentModel.instance:getMaxLevel(monumentMo:getNo())

	self._txtName.text = monumentMo:getName()

	if monumentMo:getIsFinish() then
		self._txtTime.gameObject:SetActive(true)

		local dateStr = TimeUtil.instance:stampToDateStr(monumentMo:getObtTime())

		self._txtTime.text = string.format("获得时间：%s", dateStr)

		if MonumentModel.instance:getIsSingleLevel() then
			-- block empty
		end
	else
		self._txtTime.gameObject:SetActive(false)

		if monumentMo:getIsNoShow() then
			self._txtLevel.text = "<color=#FF0000>未获得</color>"
		end
	end

	local tempStr = string.format("（<color=#2C2C2C>%d</color>/%d）", monumentMo:getUpgradeFinishCnt(), monumentMo:getUpgradeMaxCnt())

	if not monumentMo:canUpgrade() and monumentMo:getIsFinish() then
		tempStr = "<color=#AF6262>已达成</color>"
	end

	if monumentMo:getIsNoShow() and not monumentMo:getIsFinish() then
		self._txtDesc1.text = TextUtils.GetPunctuationFixedText("???" .. tempStr, self._txtDesc1, 0, 200)
		self._txtDesc2.text = "???"
		self._txtLevel.text = ""
	else
		self._txtDesc1.text = TextUtils.GetPunctuationFixedText(monumentMo:getUpgradeDesc(), self._txtDesc1, 0, 200)
		self._txtDesc2.text = monumentMo:getCupDesc()
		self._txtLevel.text = tempStr
	end

	local rate = monumentMo:getRate() * 100

	if rate < 0.01 then
		rate = 0.01
	end

	local rateStr = string.format("%.2f%%", rate)
	local layer = self:_getRateLayer(monumentMo:getRate())

	for i = 1, #self._rateTxts do
		self._rateTxts[i].text = rateStr

		goutil.setActive(self._rateTxts[i].gameObject, i == layer)
	end

	for i = 1, #self._ligthGos do
		goutil.setActive(self._ligthGos[i], i == layer)
	end
end

function M:_getRateLayer(rate)
	local layer = 1

	layer = rate >= 0 and rate <= 0.25 and 1 or rate > 0.25 and rate <= 0.5 and 2 or rate > 0.5 and rate <= 0.75 and 3 or 4

	return layer
end

return M
