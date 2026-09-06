-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunranbattle/view/SunranBuffView.lua

module("logic.extensions.sunranbattle.view.SunranBuffView", package.seeall)

local SunranBuffView = class("SunranBuffView", ViewComponent)

function SunranBuffView:ctor()
	SunranBuffView.super.ctor(self)

	self._stageCfg = nil
	self._curLeftDatas = nil
	self._curRightDatas = nil
end

function SunranBuffView:bindEvents()
	SunranBuffView.super.bindEvents(self)
	self._cancelBtn:AddClickListener(function()
		SunranBattleModel.instance:setCacheStageBuffInfo(nil)
		self:close()
	end, self)
	self._sureBtn:AddClickListener(self._onClickSureBtn, self)
	self._resetBtn:AddClickListener(self._onResetStageBuffShow, self)
end

function SunranBuffView:unbindEvents()
	SunranBuffView.super.unbindEvents(self)
	self._cancelBtn:RemoveClickListener()
	self._sureBtn:RemoveClickListener()
	self._resetBtn:RemoveClickListener()
end

function SunranBuffView:onExit()
	SunranBuffView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SingleStageInfo, self._updataLeftItemListShow, self)

	self._stageCfg = nil
	self._curLeftDatas = nil
	self._curRightDatas = nil
	self._moveRightListInViewIdx = nil
end

function SunranBuffView:destroyUI()
	SunranBuffView.super.destroyUI(self)

	local nsgBig = self._nowScoreImaGo.gameObject:GetComponent("ImageBigBG")

	if nsgBig then
		nsgBig:ClearImage()
	end

	local msgBig = self._maxScoreImaGo.gameObject:GetComponent("ImageBigBG")

	if msgBig then
		msgBig:ClearImage()
	end
end

function SunranBuffView:buildUI()
	SunranBuffView.super.buildUI(self)

	self._titleTxt = goutil.findChildTextComponent(self.mainGO, "titleGo/titleTxt")

	local leftInfoGo = self:getGo("leftInfoGo")

	self._leftListSR = goutil.findChild(leftInfoGo, "leftListSR"):GetComponent("UITableview")
	self._leftItem = goutil.findChild(leftInfoGo, "leftItem")

	self._leftItem:SetActive(false)

	local rightInfoGo = self:getGo("rightInfoGo")

	self._rightListSR = goutil.findChild(rightInfoGo, "rightListSR"):GetComponent("UITableview")
	self._rightItem = goutil.findChild(rightInfoGo, "rightItem")

	self._rightItem:SetActive(false)

	self._nowScoreTxt = goutil.findChildTextComponent(rightInfoGo, "nowScoreTxt")
	self._nowScoreImaGo = goutil.findChild(rightInfoGo, "nowScoreTxt/nowScoreIma")
	self._stateImaGo = goutil.findChild(self._nowScoreImaGo, "stateImaGo")
	self._maxScoreTxt = goutil.findChildTextComponent(rightInfoGo, "maxScoreTxt")
	self._maxScoreImaGo = goutil.findChild(rightInfoGo, "maxScoreTxt/maxScoreIma")
	self._resetBtn = Framework.ButtonAdapter.GetFrom(rightInfoGo, "resetBtn")
	self._cancelBtn = self:getBtn("cancelBtn")
	self._sureBtn = self:getBtn("sureBtn")
	self._titleTxt.text = ""
	self._nowScoreTxt.text = ""
	self._maxScoreTxt.text = ""

	self._stateImaGo:SetActive(false)
	self:registCallbacks()
end

function SunranBuffView:registCallbacks()
	self._leftListSR:RegisterCallback(self._LeftInView, function()
		return 110, 394
	end, self._LeftAtIndex, self)
	self._leftListSR:RegisterUpdateCellCallback(self._OnLeftCellUpdate)
	self._rightListSR:RegisterCallback(self._RightInView, function()
		return 394, 90
	end, self._RightAtIndex, self)
	self._rightListSR:RegisterUpdateCellCallback(self._OnRightCellUpdate)
	self._rightListSR:RegisterReloadFinishCallback(self._onRightSRViewLoadFinish, self)
end

function SunranBuffView:_LeftInView()
	if not self._curLeftDatas then
		return 0
	end

	return #self._curLeftDatas
end

function SunranBuffView:_LeftAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._leftItem)

	local data = self._curLeftDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_UpdateLeftCell(view, cell, data)

	return cell
end

function SunranBuffView:_OnLeftCellUpdate(view, cell)
	local index = cell.index
	local data = self._curLeftDatas[index + 1]

	cell.data = index + 1

	self:_UpdateLeftCell(view, cell, data)
end

function SunranBuffView:_RightInView()
	if not self._curRightDatas then
		return 0
	end

	return #self._curRightDatas
end

function SunranBuffView:_RightAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._rightItem)

	local data = self._curRightDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_UpdateRightCell(view, cell, data)

	return cell
end

function SunranBuffView:_OnRightCellUpdate(view, cell)
	local index = cell.index
	local data = self._curRightDatas[index + 1]

	cell.data = index + 1

	self:_UpdateRightCell(view, cell, data)
end

function SunranBuffView:_onRightSRViewLoadFinish(view)
	if self._moveRightListInViewIdx then
		self._rightListSR:MoveCellInView(self._moveRightListInViewIdx - 1, false)

		self._onRightSRViewLoadFinish = nil
	end
end

function SunranBuffView:onEnter()
	SunranBuffView.super.onEnter(self)

	SunranBattleModel.instance.cacheStageId = nil
	self._stageCfg = self:getFirstParam()

	local openCfg = SunranBattleConfig.instance:getOpenTimeCfg()

	if openCfg == nil then
		printError("sr---挑战 SunranBuffView:onEnter()   获取的开启时间为空")

		return
	end

	if self._stageCfg == nil or checknumber(self._stageCfg.stageId) <= 0 then
		printError("sr---挑战 SunranBuffView:onEnter()   传入的关卡配置空")

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.SingleStageInfo, self._updataLeftItemListShow, self)

	self._titleTxt.text = string.format("%s：%s", self._stageCfg.stageName, self._stageCfg.stageDes)
	self._bestScore = SunranBattleModel.instance:getStageHistoryBestScore(self._stageCfg.stageId)
	self._maxScoreTxt.text = tostring(self._bestScore)

	uGuiUtil.setSpriteToImage(self._nowScoreImaGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(openCfg.scoreIcon))
	uGuiUtil.setSpriteToImage(self._maxScoreImaGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(openCfg.scoreIcon))
	self:_updataLeftItemListShow()
	SunranBattleController.instance:csGetDarkDragonStageInfoReq(self._stageCfg.stageId)
end

function SunranBuffView:_updataLeftItemListShow()
	self._curLeftDatas = SunranBattleModel.instance:getStageBuffInfoList(self._stageCfg.seasonId, self._stageCfg.stageId)

	if self._curLeftDatas == nil or #self._curLeftDatas == 0 then
		printError("sr---挑战 SunranBuffView:onEnter()  关卡 = " .. self._stageCfg.stageId)
	end

	self:_updataRightInfoShow()
end

function SunranBuffView:_updataRightInfoShow()
	self._curRightDatas = {}

	if self._stageCfg then
		table.insert(self._curRightDatas, {
			optionGroup = 0,
			choTime = 0,
			optionId = 1,
			score = self._stageCfg.score,
			name = self._stageCfg.baseName,
			desc = self._stageCfg.baseDesc
		})
	end

	self._leftListSR:ReloadData()

	if self._curLeftDatas == nil or #self._curLeftDatas == 0 then
		self._nowScoreTxt.text = tostring(self._stageCfg.score)

		return
	end

	local allScore = self._stageCfg.score

	for i = 1, #self._curLeftDatas do
		if self._curLeftDatas[i] and checknumber(self._curLeftDatas[i].choIndex) > 0 and self._curLeftDatas[i].groupList then
			local index = self._curLeftDatas[i].choIndex
			local cfg = self._curLeftDatas[i].groupList[index]

			if cfg then
				allScore = allScore + cfg.score

				table.insert(self._curRightDatas, {
					score = cfg.score,
					name = cfg.name,
					desc = cfg.desc,
					optionId = cfg.optionId,
					optionGroup = cfg.optionGroup,
					choTime = self._curLeftDatas[i].choTime
				})
			end
		end
	end

	self._nowScoreTxt.text = tostring(allScore)

	self._stateImaGo:SetActive(allScore > self._bestScore)

	local count = #self._curRightDatas

	if count > 1 then
		table.sort(self._curRightDatas, function(a, b)
			return a.choTime < b.choTime
		end)
	end

	self._rightListSR:ReloadData()

	if count > 4 then
		if self._rightListSR.isReady then
			self._moveRightListInViewIdx = nil

			self._rightListSR:MoveCellInView(count - 1, false)
		else
			self._moveRightListInViewIdx = count
		end
	end
end

function SunranBuffView:_UpdateLeftCell(view, cell, data)
	local itemGrp = cell:GetComponent("UIChangeGroup")
	local moshiList = {}

	for i = 1, 3 do
		local go

		if i == 1 then
			go = goutil.findChild(cell, "normalGo")
		elseif i == 2 then
			go = goutil.findChild(cell, "hardGo")
		elseif i == 3 then
			go = goutil.findChild(cell, "abyssGo")
		end

		local list = {}

		list.itemGo = go
		list.buffImaGo = goutil.findChild(go, "buffImaGo")
		list.scoreTxt = goutil.findChildTextComponent(go, "scoreTxt")
		list.resetGo = goutil.findChild(go, "resetGo")
		list.selectGo = goutil.findChild(go, "selectGo")
		list.nameTxt = goutil.findChildTextComponent(go, "nameTxt")

		table.insert(moshiList, list)
	end

	local lockGo = goutil.findChild(cell, "lockGo")
	local lockTxt = goutil.findChildTextComponent(lockGo, "lockTxt")
	local yu = cell.data - math.floor(cell.data / 2) * 2

	itemGrp:SetState(yu)

	if data.needScore <= 0 or data.needScore <= self._bestScore then
		lockTxt.text = ""

		lockGo:SetActive(false)
	else
		lockGo:SetActive(true)

		lockTxt.text = string.format("最高记录达%s解锁", data.needScore)
	end

	for i = 1, #moshiList do
		if moshiList[i] and moshiList[i].itemGo then
			GameUtil.asBtn(moshiList[i].itemGo):RemoveClickListener()

			if data.groupList and data.groupList[i] then
				local info = data.groupList[i]

				moshiList[i].itemGo:SetActive(true)
				uGuiUtil.setSpriteToImage(moshiList[i].buffImaGo, uGuiUtil.SpriteType.BigBg, string.format("ui/icon/%s.png", info.icon))

				moshiList[i].scoreTxt.text = tostring(info.score)
				moshiList[i].nameTxt.text = info.name

				if checknumber(data.choIndex) > 0 then
					moshiList[i].resetGo:SetActive(data.choIndex ~= i)
					moshiList[i].selectGo:SetActive(data.choIndex == i)
				else
					moshiList[i].resetGo:SetActive(false)
					moshiList[i].selectGo:SetActive(false)
				end

				GameUtil.asBtn(moshiList[i].itemGo):AddClickListener(function()
					self:_onClickBuffItemBtn(data.groupId, i)
				end, self)
			else
				moshiList[i].itemGo:SetActive(false)
			end
		end
	end
end

function SunranBuffView:_onClickBuffItemBtn(groupId, index)
	if checknumber(groupId) <= 0 or checknumber(index) <= 0 then
		return
	end

	if self._curLeftDatas == nil or #self._curLeftDatas == 0 then
		return
	end

	for i = 1, #self._curLeftDatas do
		if self._curLeftDatas[i] and self._curLeftDatas[i].groupId == groupId then
			if self._curLeftDatas[i].needScore > 0 and self._curLeftDatas[i].needScore > self._bestScore then
				FloatWordMgr.instance:show(string.format("最高记录达%s解锁", self._curLeftDatas[i].needScore))

				return
			end

			if self._curLeftDatas[i].choIndex == index then
				self._curLeftDatas[i].choIndex = 0

				break
			end

			self._curLeftDatas[i].choIndex = index
			self._curLeftDatas[i].choTime = ServerTime.now()

			break
		end
	end

	self:_updataRightInfoShow()
end

function SunranBuffView:_UpdateRightCell(view, cell, data)
	local scoreTxt = goutil.findChildTextComponent(cell, "scoreTxt")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local descTxt = goutil.findChildTextComponent(cell, "descTxt")
	local deleteBtnGo = goutil.findChild(cell, "deleteBtn")

	GameUtil.asBtn(deleteBtnGo):RemoveClickListener()

	scoreTxt.text = tostring(data.score)
	nameTxt.text = data.name

	nameTxt.gameObject:GetComponent("UITextColorChange"):SetState(data.optionId - 1)

	descTxt.text = data.desc

	if checknumber(data.optionGroup) > 0 then
		deleteBtnGo:SetActive(true)
		GameUtil.asBtn(deleteBtnGo):AddClickListener(function()
			self:_onClickBuffMinusBtn(data.optionGroup)
		end)
	else
		deleteBtnGo:SetActive(false)
	end
end

function SunranBuffView:_onClickBuffMinusBtn(groupId)
	if checknumber(groupId) <= 0 then
		return
	end

	if self._curLeftDatas == nil or #self._curLeftDatas == 0 then
		return
	end

	for i = 1, #self._curLeftDatas do
		if self._curLeftDatas[i] and self._curLeftDatas[i].groupId == groupId then
			self._curLeftDatas[i].choIndex = 0

			break
		end
	end

	self:_updataRightInfoShow()
end

function SunranBuffView:_onResetStageBuffShow()
	self._nowScoreTxt.text = tostring(self._stageCfg.score)

	if self._curLeftDatas == nil or #self._curLeftDatas == 0 then
		return
	end

	for i = 1, #self._curLeftDatas do
		if self._curLeftDatas[i] then
			self._curLeftDatas[i].choIndex = 0
		end
	end

	self._leftListSR:ReloadData()

	self._curRightDatas = {}

	if self._stageCfg then
		table.insert(self._curRightDatas, {
			optionGroup = 0,
			optionId = 1,
			score = self._stageCfg.score,
			name = self._stageCfg.baseName,
			desc = self._stageCfg.baseDesc
		})
	end

	self._rightListSR:ReloadData()
	SunranBattleModel.instance:setCacheStageBuffInfo(nil)
end

function SunranBuffView:_onClickSureBtn()
	if self._curLeftDatas == nil or #self._curLeftDatas == 0 then
		return
	end

	local tragetList = {}

	for i = 1, #self._curLeftDatas do
		if self._curLeftDatas[i] and self._curLeftDatas[i].choIndex > 0 then
			table.insert(tragetList, {
				optionGroup = self._curLeftDatas[i].groupId,
				optionId = self._curLeftDatas[i].choIndex
			})
		end
	end

	local tempInfo = {
		seasonId = self._stageCfg.seasonId,
		stageId = self._stageCfg.stageId,
		masterId = self._stageCfg.creepsMasterId
	}

	if #tragetList > 0 then
		tempInfo.groupList = tragetList
	end

	SunranBattleModel.instance:setCacheStageBuffInfo(tempInfo)

	local params = SunranBattleModel.instance:getStageMissionFmtInfo()

	if params == nil or checknumber(params.stageId) <= 0 or checknumber(params.masterId) <= 0 then
		printError("sr---挑战   SunranBuffView:_onClickSureBtn()   去布阵界面出错")
		SunranBattleModel.instance:setCacheStageBuffInfo()
		self:close()

		return
	end

	SunranBattleModel.instance.cacheStageId = self._stageCfg.stageId

	UIStateManager.instance:push(ViewName.SRMission, params)
	self:close()
end

return SunranBuffView
