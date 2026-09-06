-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/moonking/view/MoonKingBuffView.lua

module("logic.extensions.moonking.view.MoonKingBuffView", package.seeall)

local MoonKingBuffView = class("MoonKingBuffView", ViewComponent)

function MoonKingBuffView:ctor()
	MoonKingBuffView.super.ctor(self)

	self._curLeftDatas = nil
	self._curRightDatas = nil
	self._isOpenView = nil
	self._moveRightListInViewIdx = nil
end

function MoonKingBuffView:bindEvents()
	MoonKingBuffView.super.bindEvents(self)
	self._arrowBtn:AddClickListener(self._onClickArrowBtn, self)
	self._resetBtn:AddClickListener(self._updataLeftItemListShow, self)
	GameUtil.asBtn(self._viewClickGo):AddClickListener(self._onClickArrowBtn, self)
end

function MoonKingBuffView:unbindEvents()
	MoonKingBuffView.super.unbindEvents(self)
	self._arrowBtn:RemoveClickListener()
	self._resetBtn:RemoveClickListener()
	GameUtil.asBtn(self._viewClickGo):RemoveClickListener()
end

function MoonKingBuffView:onExit()
	MoonKingBuffView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SingleStageInfo, self._updataLeftItemListShow, self)

	self._curLeftDatas = nil
	self._curRightDatas = nil
	self._isOpenView = nil
	self._moveRightListInViewIdx = nil
end

function MoonKingBuffView:destroyUI()
	MoonKingBuffView.super.destroyUI(self)

	local nsgBig = self._nowScoreImaGo.gameObject:GetComponent("ImageBigBG")

	if nsgBig then
		nsgBig:ClearImage()
	end

	local msgBig = self._maxScoreImaGo.gameObject:GetComponent("ImageBigBG")

	if msgBig then
		msgBig:ClearImage()
	end
end

function MoonKingBuffView:buildUI()
	MoonKingBuffView.super.buildUI(self)

	self._viewClickGo = self:getGo("viewClickGo")
	self._viewBgGo = self:getGo("viewBgGo")
	self._arrowBtn = self:getBtn("viewBgGo/arrowBtn")
	self._arrowTran = self:getGo("viewBgGo/arrowBtn/arrowTran").transform
	self._allInfoGo = goutil.findChild(self._viewBgGo, "allInfoGo")

	local leftInfoGo = goutil.findChild(self._allInfoGo, "leftInfoGo")

	self._leftListSR = goutil.findChild(leftInfoGo, "leftListSR"):GetComponent("UITableview")
	self._leftItem = goutil.findChild(leftInfoGo, "leftItem")

	self._leftItem:SetActive(false)

	local rightInfoGo = goutil.findChild(self._allInfoGo, "rightInfoGo")

	self._rightListSR = goutil.findChild(rightInfoGo, "rightListSR"):GetComponent("UITableview")
	self._rightItem = goutil.findChild(rightInfoGo, "rightItem")

	self._rightItem:SetActive(false)

	self._nowScoreTxt = goutil.findChildTextComponent(rightInfoGo, "nowScoreTxt")
	self._nowScoreImaGo = goutil.findChild(rightInfoGo, "nowScoreTxt/nowScoreIma")
	self._stateImaGo = goutil.findChild(self._nowScoreImaGo, "stateImaGo")
	self._maxScoreTxt = goutil.findChildTextComponent(rightInfoGo, "maxScoreTxt")
	self._maxScoreImaGo = goutil.findChild(rightInfoGo, "maxScoreTxt/maxScoreIma")
	self._resetBtn = Framework.ButtonAdapter.GetFrom(rightInfoGo, "resetBtn")
	self._nowScoreTxt.text = ""
	self._maxScoreTxt.text = ""

	self._stateImaGo:SetActive(false)
	self:registCallbacks()
end

function MoonKingBuffView:registCallbacks()
	self._leftListSR:RegisterCallback(self._LeftInView, function()
		return 110, 404
	end, self._LeftAtIndex, self)
	self._leftListSR:RegisterUpdateCellCallback(self._OnLeftCellUpdate)
	self._rightListSR:RegisterCallback(self._RightInView, function()
		return 394, 90
	end, self._RightAtIndex, self)
	self._rightListSR:RegisterUpdateCellCallback(self._OnRightCellUpdate)
	self._rightListSR:RegisterReloadFinishCallback(self._onRightSRViewLoadFinish, self)
end

function MoonKingBuffView:_LeftInView()
	if not self._curLeftDatas then
		return 0
	end

	return #self._curLeftDatas
end

function MoonKingBuffView:_LeftAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._leftItem)

	local data = self._curLeftDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_UpdateLeftCell(view, cell, data)

	return cell
end

function MoonKingBuffView:_OnLeftCellUpdate(view, cell)
	local index = cell.index
	local data = self._curLeftDatas[index + 1]

	cell.data = index + 1

	self:_UpdateLeftCell(view, cell, data)
end

function MoonKingBuffView:_RightInView()
	if not self._curRightDatas then
		return 0
	end

	return #self._curRightDatas
end

function MoonKingBuffView:_RightAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._rightItem)

	local data = self._curRightDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_UpdateRightCell(view, cell, data)

	return cell
end

function MoonKingBuffView:_OnRightCellUpdate(view, cell)
	local index = cell.index
	local data = self._curRightDatas[index + 1]

	cell.data = index + 1

	self:_UpdateRightCell(view, cell, data)
end

function MoonKingBuffView:_onRightSRViewLoadFinish(view)
	if self._moveRightListInViewIdx then
		self._rightListSR:MoveCellInView(self._moveRightListInViewIdx - 1, false)

		self._onRightSRViewLoadFinish = nil
	end
end

function MoonKingBuffView:onEnter()
	MoonKingBuffView.super.onEnter(self)

	self._isOpenView = true
	self._params = self:getFirstParam()

	local baseInfo = MoonKingModel.instance:getMoonkingBaseInfo(self._params.challId)

	self._bestScore = 0

	if baseInfo and baseInfo.curStageInfo then
		self._bestScore = checknumber(baseInfo.curStageInfo.historyBestScore)
	end

	self._maxScoreTxt.text = tostring(self._bestScore)

	local challCfg = MoonKingConfig.instance:getBattleBaseCfg(self._params.challId)
	local daibiCfg = MaterialMgr.getMatCfgByStr(challCfg.scoreStr)

	uGuiUtil.setSpriteToImage(self._nowScoreImaGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(daibiCfg.icon))
	uGuiUtil.setSpriteToImage(self._maxScoreImaGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(daibiCfg.icon))
	self:_updataLeftItemListShow()
	self._viewClickGo:SetActive(true)
	self._allInfoGo:SetActive(true)
	Framework.TransformUtil.SetLocalScale(self._arrowTran, 1, 1, 1)
	Framework.TransformUtil.SetAnchoredPos(self._viewBgGo.transform, -570, 80)
end

function MoonKingBuffView:_updataLeftItemListShow()
	self._curLeftDatas = MoonKingModel.instance:getMoonkingStageBuffs(self._params.difPlanId)

	if self._curLeftDatas == nil or #self._curLeftDatas == 0 then
		printError("sr---挑战 MoonKingBuffView:_updataLeftItemListShow()  关卡 = " .. self._params.difPlanId)
	end

	self:_updataRightInfoShow()
end

function MoonKingBuffView:_updataRightInfoShow()
	self._curRightDatas = {}

	self._leftListSR:ReloadData()

	local stageCfg = MoonKingConfig.instance:getBattleStageCfgs(self._params.planId, self._params.stageId)

	if stageCfg then
		if not stageCfg.score then
			local allScore = 0

			if self._curLeftDatas == nil or #self._curLeftDatas == 0 then
				self._nowScoreTxt.text = tostring(allScore)

				self._rightListSR:ReloadData()
				MoonKingModel.instance:setMoonkingChooseBuff()

				return
			end

			local cfg
			local tragetList = {}

			for i = 1, #self._curLeftDatas do
				if self._curLeftDatas[i] and checknumber(self._curLeftDatas[i].curIndex) > 0 and self._curLeftDatas[i].groupList then
					if self._curLeftDatas[i].groupList[self._curLeftDatas[i].curIndex] then
						allScore = allScore + self._curLeftDatas[i].groupList[self._curLeftDatas[i].curIndex].score

						table.insert(self._curRightDatas, {
							score = self._curLeftDatas[i].groupList[self._curLeftDatas[i].curIndex].score,
							name = self._curLeftDatas[i].groupList[self._curLeftDatas[i].curIndex].name,
							desc = self._curLeftDatas[i].groupList[self._curLeftDatas[i].curIndex].desc,
							optionId = self._curLeftDatas[i].groupList[self._curLeftDatas[i].curIndex].optionId,
							optionGroup = self._curLeftDatas[i].groupList[self._curLeftDatas[i].curIndex].optionGroup,
							curTime = self._curLeftDatas[i].curTime
						})
						table.insert(tragetList, {
							optionGroup = self._curLeftDatas[i].groupList[self._curLeftDatas[i].curIndex].optionGroup,
							optionId = self._curLeftDatas[i].groupList[self._curLeftDatas[i].curIndex].optionId
						})
					end
				end
			end

			self._nowScoreTxt.text = tostring(allScore)

			self._stateImaGo:SetActive(allScore > self._bestScore)

			local count = #self._curRightDatas

			if count > 1 then
				table.sort(self._curRightDatas, function(a, b)
					return a.curTime < b.curTime
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

			MoonKingModel.instance:setMoonkingChooseBuff(tragetList)
		end
	end
end

function MoonKingBuffView:_UpdateLeftCell(view, cell, data)
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

	lockTxt.text = ""

	lockGo:SetActive(false)

	for i = 1, #moshiList do
		if moshiList[i] and moshiList[i].itemGo then
			GameUtil.asBtn(moshiList[i].itemGo):RemoveClickListener()

			if data.groupList and data.groupList[i] then
				local info = data.groupList[i]

				moshiList[i].itemGo:SetActive(true)
				uGuiUtil.setSpriteToImage(moshiList[i].buffImaGo, uGuiUtil.SpriteType.BigBg, string.format("ui/icon/%s.png", info.icon))

				moshiList[i].scoreTxt.text = tostring(info.score)
				moshiList[i].nameTxt.text = info.name

				if checknumber(data.curIndex) > 0 then
					moshiList[i].resetGo:SetActive(data.curIndex ~= i)
					moshiList[i].selectGo:SetActive(data.curIndex == i)
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

function MoonKingBuffView:_onClickBuffItemBtn(groupId, index)
	if checknumber(groupId) <= 0 or checknumber(index) <= 0 then
		return
	end

	if self._curLeftDatas == nil or #self._curLeftDatas == 0 then
		return
	end

	for i = 1, #self._curLeftDatas do
		if self._curLeftDatas[i] and self._curLeftDatas[i].groupId == groupId then
			if self._curLeftDatas[i].curIndex == index then
				self._curLeftDatas[i].curIndex = 0

				break
			end

			self._curLeftDatas[i].curIndex = index
			self._curLeftDatas[i].curTime = ServerTime.now()

			break
		end
	end

	self:_updataRightInfoShow()
end

function MoonKingBuffView:_UpdateRightCell(view, cell, data)
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

function MoonKingBuffView:_onClickBuffMinusBtn(groupId)
	if checknumber(groupId) <= 0 then
		return
	end

	if self._curLeftDatas == nil or #self._curLeftDatas == 0 then
		return
	end

	for i = 1, #self._curLeftDatas do
		if self._curLeftDatas[i] and self._curLeftDatas[i].groupId == groupId then
			self._curLeftDatas[i].curIndex = 0

			break
		end
	end

	self:_updataRightInfoShow()
end

function MoonKingBuffView:_onClickArrowBtn()
	self._isOpenView = not self._isOpenView

	if self._isOpenView then
		self._viewClickGo:SetActive(true)
		self._allInfoGo:SetActive(true)
		Framework.TransformUtil.SetLocalScale(self._arrowTran, 1, 1, 1)
		UnityTweens.TweenPosition.StartTween(self._viewBgGo, Vector3.New(500, 80, 0), Vector3.New(-570, 80, 0), 0.4, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
	else
		self._viewClickGo:SetActive(false)
		Framework.TransformUtil.SetLocalScale(self._arrowTran, -1, 1, 1)

		local tweenPos = UnityTweens.TweenPosition.StartTween(self._viewBgGo, Vector3.New(-570, 80, 0), Vector3.New(500, 80, 0), 0.4, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)

		tweenPos:AddListener(function()
			if not self._isOpenView then
				self._allInfoGo:SetActive(false)
			end
		end)
	end
end

return MoonKingBuffView
