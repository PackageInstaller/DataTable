-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamyouth/view/DreamtaskView.lua

module("logic.extensions.dreamyouth.view.DreamtaskView", package.seeall)

local DreamtaskView = class("DreamtaskView", ViewComponent)

function DreamtaskView:buildUI()
	DreamtaskView.super.buildUI(self)

	self.ScrollView = self:getGo("ScrollView")
	self.Cell = self:getGo("Cell")
	self._tableview = ScrollerList.create(self.ScrollView, self.Cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnPack = {}
	self._icon = {}
	self._txtPackName = {}

	for i = 1, 3 do
		self._btnPack[i] = self:getBtn("btnPack" .. i)
		self._icon[i] = self:getGo("btnPack" .. i .. "/item")
		self._txtPackName[i] = self:getTxt("btnPack" .. i .. "/txtBuy")
	end

	self._rare = self:getGo("petInfo/rare")
	self._con = self:getGo("con")
	self._role = nil
	self._code = self:getGo("code")
	self._codeItemcon = self:getGo("code/itemcon/item1")
	self._btnCodeJump = self:getBtn("code/btnJumpTo")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._btnSkill = self:getGo("petInfo/btnSkill")
end

function DreamtaskView:bindEvents()
	DreamtaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSkill, GameUtil.handler(self._onClickbtnSkill, self))
	GameUtil.addClickHandler(self._btnInfo, GameUtil.handler(self._onClickInfo, self))
	GameUtil.addClickHandler(self._btnCodeJump, GameUtil.handler(self._onCodeJump, self))

	for i = 1, 3 do
		GameUtil.addClickHandler(self._btnPack[i], GameUtil.handler(self._onClickPack, self, i))
	end
end

function DreamtaskView:unbindEvents()
	for i = 1, 3 do
		GameUtil.rmClickHandler(self._btnPack[i])
	end

	GameUtil.rmClickHandler(self._btnCodeJump)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
	DreamtaskView.super.unbindEvents(self)
end

function DreamtaskView:onEnter()
	DreamtaskView.super.onEnter(self)

	self._raceId = 14005

	DreamyouthController.instance:registerNotify(DreamyouthController.DATA_CHANGE, self._updateUI, self)
	DreamyouthController.instance:getTaskInfo()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._raceId, self._con)

	MaterialMgr.setCell(MatType.Rare, self._raceId, self._rare)

	for i = 1, 3 do
		local goodsId = DreamyouthConfig.instance:getPackId(i)
		local mibaoCfg = PayShopConfig.instance:getPayShopGoodsCfgById(goodsId)

		uGuiUtil.setSpriteToImage(self._icon[i], nil, GameUrl.getItemIconUrl(mibaoCfg.icon))

		self._txtPackName[i].text = mibaoCfg.name
	end

	local arr = string.split(DreamyouthConfig.instance:getCoinItemStr(), ":")

	MaterialMgr.setCellByCfg(string.format("%s:%s:%s", arr[1], arr[2], 300), self._codeItemcon)
end

function DreamtaskView:onExit()
	RoleObjectPool.instance:removeRole(self._role)

	self._role = nil

	MaterialMgr.resetAll(self._rare)

	for i = 1, 3 do
		uGuiUtil.clearImage(self._icon[i])
	end

	MaterialMgr.resetAll(self._codeItemcon)
	self._tableview:dispose()
	DreamyouthController.instance:unregisterNotify(DreamyouthController.DATA_CHANGE, self._updateUI, self)
	DreamtaskView.super.onExit(self)
end

function DreamtaskView:_onClickInfo()
	if self._raceId then
		PetbookController.instance:openPetinfoView(self._raceId)
	end
end

function DreamtaskView:_onClickbtnSkill()
	if self._raceId then
		PetCvController.instance:turnOffCurCv()
		PetbookController.instance:previewBattle(self._raceId)
	end
end

function DreamtaskView:_onCodeJump()
	UIStateManager.instance:push(ViewName.DreamyouthtipView)
end

function DreamtaskView:_onClickPack(i)
	local goodsId = DreamyouthConfig.instance:getPackId(i)
	local isCanBuy = PayShopModel.instance:getPayShopGoodsCanBuyById(goodsId)

	if isCanBuy then
		local data = PayShopModel.instance:getBuyData(goodsId)

		if data then
			UIStateManager.instance:push(ViewName.PayShopMibaoBuyView, data)
		else
			printError("配置错误")
		end
	else
		FloatWordMgr.instance:show(lang("text_recall_desc_6"))

		return
	end
end

function DreamtaskView:_updateCell(view, cell, data)
	local btnGain = goutil.findChild(cell, "btnGain")
	local btnJumpTo = goutil.findChild(cell, "btnJumpTo")
	local maskFinish = goutil.findChild(cell, "maskFinish")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local curProgress = DreamyouthModel.instance:getTaskCurProcess(data.id)
	local hasGainPrize = DreamyouthModel.instance:hasGainTaskPrize(data.id)

	txtName.text = string.format("%s\n(%d/%d)\n总共<color=#eb4642>%d</color>能量", data.desc, curProgress, data.maxProgress, DreamyouthConfig.instance:taskPrizeTotal(data.type))

	goutil.setActive(maskFinish, hasGainPrize)
	goutil.setActive(btnGain, not hasGainPrize and curProgress >= data.maxProgress)
	goutil.setActive(btnJumpTo, curProgress < data.maxProgress)

	local itemCon = goutil.findChild(cell, "itemcon")
	local materialList = {}

	for i = 1, 3 do
		materialList[i] = {}
		materialList[i].mainGo = goutil.findChild(itemCon, "item" .. i)
	end

	self:_setReward(materialList, data.prize)
	GameUtil.addClickHandler(btnGain, GameUtil.handler(self._onClickGain, self, data))
	GameUtil.addClickHandler(btnJumpTo, GameUtil.handler(self._onClickJumpTo, self, data))
end

function DreamtaskView:_clearCell(cell)
	local itemCon = goutil.findChild(cell, "itemcon")

	MaterialMgr.resetAll(itemCon)

	local btnGain = goutil.findChild(cell, "btnGain")

	GameUtil.rmClickHandler(btnGain)

	local btnJumpTo = goutil.findChild(cell, "btnJumpTo")

	GameUtil.rmClickHandler(btnJumpTo)
end

function DreamtaskView:_onClickGain(data)
	DreamyouthController.instance:gainTaskPrize(data.id)
end

function DreamtaskView:_onClickJumpTo(data)
	GotoMgr.gotoByString(data.jumpTo)
end

function DreamtaskView:_updateUI()
	self._tableview:reloadData(self:getTaskShow())
end

function DreamtaskView:getTaskShow()
	local allTask = DreamyouthConfig.instance:getTaskCfg()
	local allType = {}
	local valueMinMap = {}
	local valueMaxMap = {}

	for i, v in ipairs(allTask) do
		local type = v.type
		local hasGainPrize = DreamyouthModel.instance:hasGainTaskPrize(v.id)

		if allType[type] == nil then
			allType[type] = type
		end

		if not hasGainPrize and (valueMinMap[type] == nil or valueMinMap[type].maxProgress > v.maxProgress) then
			valueMinMap[type] = v
		end

		if valueMaxMap[type] == nil or valueMaxMap[type].maxProgress < v.maxProgress then
			valueMaxMap[type] = v
		end
	end

	local result = {}

	for i, v in pairs(allType) do
		if valueMinMap[v] == nil then
			table.insert(result, valueMaxMap[v])
		else
			table.insert(result, valueMinMap[v])
		end
	end

	return result
end

function DreamtaskView:_setReward(materialList, content)
	local arr = string.split(content, "#")

	for i, v in ipairs(arr) do
		if i > #materialList then
			return
		end

		MaterialMgr.resetAll(materialList[i].mainGo)
		MaterialMgr.setCellByCfg(v, materialList[i].mainGo)
	end

	for i = #arr + 1, #materialList do
		goutil.setActive(materialList[i].mainGO, false)
	end
end

return DreamtaskView
