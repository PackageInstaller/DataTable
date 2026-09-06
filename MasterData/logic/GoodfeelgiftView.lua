-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeelgiftView.lua

module("logic.extensions.goodfeel.view.GoodfeelgiftView", package.seeall)

local GoodfeelgiftView = class("GoodfeelgiftView", TableViewComponent)

GoodfeelgiftView.BtnType = {
	UpTo20 = 2,
	Up5 = 1
}

function GoodfeelgiftView:ctor()
	GoodfeelgiftView.super.ctor(self)

	self._upTo20Level = 20
end

function GoodfeelgiftView:_getPath()
	return {
		cellPath = "giftCon/goodfeelgiftview/mask/root/tablecell",
		viewPath = "giftCon/goodfeelgiftview/mask/root/tableview"
	}
end

function GoodfeelgiftView:buildUI()
	GoodfeelgiftView.super.buildUI(self)

	self._sendBtn = self:getBtn("giftCon/goodfeelgiftview/mask/root/sendBtn")
	self._giftUseCfgs = {}
	self._rootTween = self:getGo("giftCon/goodfeelgiftview/mask/root"):GetComponent(UnityTweensType.TweenPosition)
	self._BtnMinus = self:getBtn("giftCon/goodfeelgiftview/BgNum/BtnMinus")
	self._BtnAdd = self:getBtn("giftCon/goodfeelgiftview/BgNum/BtnAdd")
	self._inputTxt = self:getInput("giftCon/goodfeelgiftview/BgNum/txtNumBg")
	self._levelUpOne = self:getBtn("giftCon/goodfeelgiftview/btnUpdateOne")
	self._levelUpFive = self:getBtn("giftCon/goodfeelgiftview/btnUpdateFive")
end

function GoodfeelgiftView:bindEvents()
	GoodfeelgiftView.super.bindEvents(self)
	self._sendBtn:AddClickListener(self._onClickSend, self)
	self._BtnMinus:AddClickListener(self._onClickBtnMinus, self)
	self._BtnAdd:AddClickListener(self._onClickBtnAdd, self)
	self._inputTxt:AddOnValueChanged(self._onInputTxtValueChange, self)
	self._levelUpOne:AddClickListener(function()
		self:_onClickLevelUp(GoodfeelgiftView.BtnType.Up5)
	end, self)
	self._levelUpFive:AddClickListener(function()
		self:_onClickLevelUp(GoodfeelgiftView.BtnType.UpTo20)
	end, self)
end

function GoodfeelgiftView:unbindEvents()
	GoodfeelgiftView.super.unbindEvents(self)
	self._sendBtn:RemoveClickListener()
	self._BtnMinus:RemoveClickListener()
	self._BtnAdd:RemoveClickListener()
	self._inputTxt:RemoveOnValueChanged()
	self._levelUpOne:RemoveClickListener()
	self._levelUpFive:RemoveClickListener()
end

function GoodfeelgiftView:destroyUI()
	GoodfeelgiftView.super.destroyUI(self)
end

function GoodfeelgiftView:onEnter()
	GoodfeelgiftView.super.onEnter(self)
	GoodFeelController.instance:addUseItemListener()
	GlobalDispatcher:addListener(GoodFeelController.RealUseGift, self._useGiftRes, self)
	GlobalDispatcher:addListener(GoodFeelModel.ChangePetShow, self._onChangePetShow, self)
	GlobalDispatcher:addListener(GoodFeelController.UseGiftError, self.reloadData, self)
	GlobalDispatcher:addListener(MaterialAgent.UseMaterialRes, self.reloadData, self)
	self:_setCurrRaceIdAndSkinId()

	self._lastLv = GoodFeelModel.instance:getPetGoodFeelLv(self._raceId)
	self._isFirstEnter = true
	self._matNum = 0
	self._sendNum = 1
	self._curViewDatas = GoodFeelModel.instance:getSendGiftList()

	self:_updateView()
	self:_doMove()
end

function GoodfeelgiftView:onEnterFinished()
	GoodfeelgiftView.super.onEnterFinished(self)
end

function GoodfeelgiftView:onExit()
	GoodfeelgiftView.super.onExit(self)
	self._rootTween:Stop()
	GoodFeelController.instance:removeUseItemListener()
	GlobalDispatcher:removeListener(GoodFeelModel.ChangePetShow, self._onChangePetShow, self)
	GlobalDispatcher:removeListener(GoodFeelController.RealUseGift, self._useGiftRes, self)
	GlobalDispatcher:removeListener(GoodFeelController.UseGiftError, self.reloadData, self)
	GlobalDispatcher:removeListener(MaterialAgent.UseMaterialRes, self.reloadData, self)
	removetimer(self._onLongPressTick, self)
	MaterialMgr.resetAll(self._tableview.gameObject)

	self._binder = nil
	self._selectId = nil
	self._nextSelectId = false

	ViewBlockMgr.instance:blockClick(false, "GoodfeelgiftView")
end

function GoodfeelgiftView:onExitFinished()
	GoodfeelgiftView.super.onExitFinished(self)
end

function GoodfeelgiftView:_onInputTxtValueChange(numStr)
	self:_autoModifUseNum(numStr)
end

function GoodfeelgiftView:_autoModifUseNum(numStr)
	local num = checknumber(numStr)

	if num <= 1 then
		self._sendNum = 1

		self._inputTxt:SetText("1")
	elseif num > self._matNum then
		self._sendNum = self._matNum

		self._inputTxt:SetText(tostring(self._sendNum))
	else
		local currExp = GoodFeelModel.instance:getGoodFeelExp(self._raceId)
		local cfgs = GoodFeelConfig.instance:getGoodFeelExpCfgs()
		local lastCfg = cfgs[#cfgs]
		local needNum = math.ceil((lastCfg.exp - currExp) / self._perExp)

		if needNum < num then
			num = needNum

			self._inputTxt:SetText(tostring(needNum))
		end

		self._sendNum = num
	end
end

function GoodfeelgiftView:_calOneMatExp()
	self._perExp = self:_getAddExpPer(self._selectId)
end

function GoodfeelgiftView:_onClickSend()
	if GoodFeelModel.instance:isMaxLv(self._raceId) then
		FloatWordMgr.instance:show("该精灵好感度已达到满级，无法收礼了")

		return
	end

	local hasNum = MaterialMgr.getMatCount(string.format("%s:%s", MatType.Item, self._selectId))

	if hasNum <= 0 then
		FloatWordMgr.instance:show("物品数量不足1个")

		return
	end

	self:_doSendGift()
end

function GoodfeelgiftView:_onClickBtnMinus()
	if self._sendNum > 1 then
		self._sendNum = self._sendNum - 1

		self._inputTxt:SetText(tostring(self._sendNum))
	else
		FloatWordMgr.instance:show("当前已为最小值")
	end
end

function GoodfeelgiftView:_onClickBtnAdd()
	if GoodFeelModel.instance:isMaxLv(self._raceId) then
		FloatWordMgr.instance:show("该精灵好感度已达到满级")

		return
	end

	if self._sendNum < self._matNum then
		self._sendNum = self._sendNum + 1

		self._inputTxt:SetText(tostring(self._sendNum))
	else
		FloatWordMgr.instance:show("当前已为最大值")
	end
end

function GoodfeelgiftView:_doSendGift()
	self:_doSendMultGift()
end

function GoodfeelgiftView:_playClientAddExpAni()
	local exp = self._perExp * self._sendNum

	GlobalDispatcher:dispatch(GoodFeelModel.DoSendGiftAni, exp, self._sendNum)
end

function GoodfeelgiftView:_doSendMultGift()
	if self._sendNum and self._sendNum > 0 then
		local currLv = GoodFeelModel.instance:getPetGoodFeelLv(self._raceId)

		GoodFeelModel.instance:setUnlockData(self._raceId, currLv, self._skinId)

		local list = {
			{
				id = self._selectId,
				num = self._sendNum
			}
		}
		local addExp = self._perExp * self._sendNum

		GoodFeelModel.instance:setCachePetInfo(self._raceId, list, addExp)
		MaterialFacade.instance:batchUseItem(MatType.Item, list, "{\"ri\":" .. self._raceId .. "}", function()
			GlobalDispatcher:dispatch(GoodFeelModel.DoSendGiftAni, addExp)
		end)
	end
end

function GoodfeelgiftView:_cellSize(view, index)
	return 120, 100
end

function GoodfeelgiftView:_updateCell(view, cell, data)
	if self._nextSelectId then
		self._selectId = self._nextSelectId
		self._nextSelectId = false
	end

	local itemCon = goutil.findChild(cell.gameObject, "itemCon")
	local selectGo = goutil.findChild(cell.gameObject, "select")
	local btn = GameUtil.asBtn(goutil.findChild(cell.gameObject, "raycast"))

	MaterialMgr.resetAll(itemCon)

	local hasNum = MaterialFacade.instance:getMatNumber(MatType.Item, data.id)
	local cfgStr = string.format("%s:%s:%s", MatType.Item, data.id, hasNum)
	local proxy = MaterialMgr.setCellByCfg(cfgStr, itemCon)

	goutil.setActive(selectGo, self._selectId == data.id)
	goutil.setActive(btn.gameObject, self._selectId ~= data.id)

	if self._selectId == data.id then
		self._binder = proxy.binder
	end

	GameUtil.SetGray(itemCon, hasNum <= 0)
	btn:RemoveClickListener()
	btn:AddClickListener(function()
		proxy.binder:_OnClick()
		self:_onClickItemCell(data.id, cell.data)
	end)
end

function GoodfeelgiftView:_onClickItemCell(selectId, index)
	self._selectId = selectId
	self._selectIndex = index
	self._matsStr = MatType.Item .. ":" .. self._selectId .. ":1"
	self._matNum = MaterialMgr.getMatCount(self._matsStr)

	self:_calOneMatExp()

	self._sendNum = self:_calNextLvNeedNum(self._raceId, self._selectId, self._matNum)

	self._inputTxt:SetText(tostring(self._sendNum))
	self:reloadData()
end

function GoodfeelgiftView:_calNextLvNeedNum(raceId, itemId, matNum)
	local needNum = 1

	if not GoodFeelModel.instance:isMaxLv(raceId) then
		local currExp = GoodFeelModel.instance:getGoodFeelExp(raceId)
		local currLv = GoodFeelConfig.instance:getLvByGoodFeelExp(currExp)
		local nextLv = currLv + 1
		local ncfg = GoodFeelConfig.instance:getGoodFeelExpCfg(nextLv)
		local needExp = ncfg.exp - currExp

		needNum = math.ceil(needExp / self._perExp)
		needNum = math.min(needNum, matNum)
	end

	return needNum
end

function GoodfeelgiftView:_clearTableview(cell)
	return
end

function GoodfeelgiftView:_onReloadFinish()
	if self._selectIndex and self._isFirstEnter then
		self._isFirstEnter = false

		self:moveCellToCenter(self._selectIndex)
	end
end

function GoodfeelgiftView:_useGiftRes()
	if self._matsStr then
		self._matNum = MaterialMgr.getMatCount(self._matsStr)

		if self._matNum <= 0 then
			self._nextSelectId = self:_autoCalNextSelectId()
			self._selectId = self._nextSelectId or self._selectId

			if self._nextSelectId then
				self:_onClickItemCell(self._nextSelectId)
			else
				self._sendNum = 1

				self._inputTxt:SetText(tostring(self._sendNum))
			end
		else
			self:_autoModifUseNum(self._sendNum)
		end
	end

	self:_updateView()
end

function GoodfeelgiftView:_updateView()
	local hasNumList = {}

	for i, v in ipairs(self._curViewDatas) do
		hasNumList[v.id] = MaterialFacade.instance:getMatNumber(MatType.Item, v.id)
	end

	local enoughList = {}
	local notEnoughList = {}

	for i, v in ipairs(self._curViewDatas) do
		if hasNumList[v.id] <= 0 then
			table.insert(notEnoughList, v)
		else
			table.insert(enoughList, v)
		end
	end

	table.sort(enoughList, function(a, b)
		if a.quality == b.quality then
			return a.id < b.id
		else
			return a.quality > b.quality
		end
	end)
	table.insertto(enoughList, notEnoughList)

	self._curViewDatas = enoughList

	if not self._selectId then
		self._selectIndex = 1
		self._selectId = self._curViewDatas[self._selectIndex] and self._curViewDatas[self._selectIndex].id

		self:_onClickItemCell(self._selectId, self._selectIndex)
	end

	self:reloadData()
end

function GoodfeelgiftView:_getAddExpPer(matId)
	local matType = MatType.Item
	local key = matType .. "@" .. matId
	local cfg = self._giftUseCfgs[key]

	if not cfg then
		cfg = MaterialConfig.instance:getCfgByMatAndId(matType, matId)
		self._giftUseCfgs[key] = cfg
	end

	if cfg ~= nil then
		return checknumber(cfg.content)
	else
		return 0
	end
end

function GoodfeelgiftView:_onChangePetShow()
	self:_setCurrRaceIdAndSkinId()

	self._lastLv = GoodFeelModel.instance:getPetGoodFeelLv(self._raceId)
end

function GoodfeelgiftView:_setCurrRaceIdAndSkinId()
	self._raceId, self._skinId = GoodFeelModel.instance:getPetShowViewCurrRaceId()
end

function GoodfeelgiftView:_doMove()
	self._rootTween:Begin()
end

function GoodfeelgiftView:_autoCalNextSelectId()
	local nextSelectId = false

	for i, v in ipairs(self._curViewDatas) do
		if v.id ~= self._selectId then
			local hasNum = MaterialFacade.instance:getMatNumber(MatType.Item, v.id)

			if hasNum > 0 then
				nextSelectId = v.id
				self._selectIndex = i
				self._isFirstEnter = true

				break
			end
		end
	end

	return nextSelectId
end

function GoodfeelgiftView:_onClickLevelUp(btnType)
	if GoodFeelModel.instance:isMaxLv(self._raceId) then
		FloatWordMgr.instance:show("该精灵好感度已达到满级")

		return
	end

	local currLv = GoodFeelModel.instance:getPetGoodFeelLv(self._raceId)
	local levelNum = 0

	if btnType == GoodfeelgiftView.BtnType.Up5 then
		levelNum = 5
	elseif btnType == GoodfeelgiftView.BtnType.UpTo20 then
		if currLv >= self._upTo20Level then
			FloatWordMgr.instance:show(string.format("该精灵好感度已达到%s级", self._upTo20Level))

			return
		end

		levelNum = self._upTo20Level - currLv
	end

	local currLv = GoodFeelModel.instance:getPetGoodFeelLv(self._raceId)
	local curExp = GoodFeelModel.instance:getGoodFeelExp(self._raceId)
	local needExp = self:_getNeedExpByLevelNum(curExp, levelNum)
	local addExp = 0
	local list = {}

	for i, v in ipairs(self._curViewDatas) do
		local item = {}
		local expOneItem = self:_getAddExpPer(v.id)
		local num = MaterialFacade.instance:getMatNumber(MatType.Item, v.id)
		local needCount = math.ceil(needExp / expOneItem)
		local maxSelect = math.min(needCount, num)

		needExp = needExp - expOneItem * maxSelect

		if maxSelect > 0 then
			item.id = v.id
			item.num = maxSelect

			table.insert(list, item)
		end

		addExp = addExp + expOneItem * maxSelect

		if needExp <= 0 then
			break
		end
	end

	if #list <= 0 then
		FloatWordMgr.instance:show("当前材料不足")

		return
	end

	GoodFeelModel.instance:setCachePetInfo(self._raceId, list, addExp)
	GoodFeelModel.instance:setUnlockData(self._raceId, currLv, self._skinId)
	MaterialFacade.instance:batchUseItem(MatType.Item, list, "{\"ri\":" .. self._raceId .. "}", function()
		GlobalDispatcher:dispatch(GoodFeelModel.DoSendGiftAni, addExp)
	end)
end

function GoodfeelgiftView:_getNeedExpByLevelNum(curExp, levelNum)
	local cfgs = GoodFeelConfig.instance:getGoodFeelExpCfgs()

	for i, v in ipairs(cfgs) do
		if curExp < v.exp then
			local curLevel = i - 1

			if curLevel + levelNum > #cfgs then
				if not #cfgs then
					local lastLevel = curLevel + levelNum

					return checknumber(cfgs[lastLevel].exp) - curExp
				end
			end
		end
	end

	return 0
end

return GoodfeelgiftView
