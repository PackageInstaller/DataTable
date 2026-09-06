-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicedtower/view/PsychicedTowerFmtView.lua

module("logic.extensions.psychicedtower.view.PsychicedTowerFmtView", package.seeall)

local PsychicedTowerFmtView = class("PsychicedTowerFmtView", ViewComponent)

function PsychicedTowerFmtView:ctor()
	PsychicedTowerFmtView.super.ctor(self)

	self._curLeftDatas = nil
	self._curRightDatas = nil
	self._isOpenView = nil
	self._moveRightListInViewIdx = nil
end

function PsychicedTowerFmtView:bindEvents()
	PsychicedTowerFmtView.super.bindEvents(self)
	self._arrowBtn:AddClickListener(self._onClickArrowBtn, self)
	self._resetBtn:AddClickListener(self._onClickReset, self)
	GameUtil.asBtn(self._viewClickGo):AddClickListener(self._onClickArrowBtn, self)
end

function PsychicedTowerFmtView:unbindEvents()
	PsychicedTowerFmtView.super.unbindEvents(self)
	self._arrowBtn:RemoveClickListener()
	self._resetBtn:RemoveClickListener()
	GameUtil.asBtn(self._viewClickGo):RemoveClickListener()
end

function PsychicedTowerFmtView:onExit()
	PsychicedTowerFmtView.super.onExit(self)

	self._curLeftDatas = nil
	self._curRightDatas = nil
	self._isOpenView = nil
	self._moveRightListInViewIdx = nil
end

function PsychicedTowerFmtView:destroyUI()
	PsychicedTowerFmtView.super.destroyUI(self)
end

function PsychicedTowerFmtView:buildUI()
	PsychicedTowerFmtView.super.buildUI(self)

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

	self._nowStar = goutil.findChild(rightInfoGo, "nowScoreTxt/star")
	self._stateImaGo = goutil.findChild(rightInfoGo, "nowScoreTxt/stateImaGo")
	self._maxStar = goutil.findChild(rightInfoGo, "maxScoreTxt/star")
	self._resetBtn = Framework.ButtonAdapter.GetFrom(rightInfoGo, "resetBtn")

	GameUtil.SetActive(self._stateImaGo, false)
	self:registCallbacks()
end

function PsychicedTowerFmtView:registCallbacks()
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

function PsychicedTowerFmtView:_LeftInView()
	if not self._curLeftDatas then
		return 0
	end

	return #self._curLeftDatas
end

function PsychicedTowerFmtView:_LeftAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._leftItem)

	local data = self._curLeftDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_UpdateLeftCell(view, cell, data)

	return cell
end

function PsychicedTowerFmtView:_OnLeftCellUpdate(view, cell)
	local index = cell.index
	local data = self._curLeftDatas[index + 1]

	cell.data = index + 1

	self:_UpdateLeftCell(view, cell, data)
end

function PsychicedTowerFmtView:_RightInView()
	if not self._curRightDatas then
		return 0
	end

	return #self._curRightDatas
end

function PsychicedTowerFmtView:_RightAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._rightItem)

	local data = self._curRightDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_UpdateRightCell(view, cell, data)

	return cell
end

function PsychicedTowerFmtView:_OnRightCellUpdate(view, cell)
	local index = cell.index
	local data = self._curRightDatas[index + 1]

	cell.data = index + 1

	self:_UpdateRightCell(view, cell, data)
end

function PsychicedTowerFmtView:_onRightSRViewLoadFinish(view)
	if self._moveRightListInViewIdx then
		self._rightListSR:MoveCellInView(self._moveRightListInViewIdx - 1, false)

		self._onRightSRViewLoadFinish = nil
	end
end

function PsychicedTowerFmtView:onEnter()
	PsychicedTowerFmtView.super.onEnter(self)

	self._isOpenView = true
	self._fmtMo = self:getFirstParam()
	self._bestScore = PsychicedTowerModel.instance:getStageInfo(self._fmtMo.activityId, self._fmtMo.towerId, self._fmtMo.stageId) or 0

	self:updateStar(self._maxStar, self._bestScore)
	self:_updataLeftItemListShow()
	self._viewClickGo:SetActive(true)
	self._allInfoGo:SetActive(true)
	Framework.TransformUtil.SetLocalScale(self._arrowTran, 1, 1, 1)
	Framework.TransformUtil.SetAnchoredPos(self._viewBgGo.transform, -330, 80)
end

function PsychicedTowerFmtView:_updataLeftItemListShow()
	local cfg = PsychicedTowerConfig.instance:getStageCfg(self._fmtMo.activityId, self._fmtMo.towerId, self._fmtMo.stageId)

	self._curLeftDatas = PsychicedTowerModel.instance:getStageBuffs(cfg.buffPlanId)

	if self._curLeftDatas == nil or #self._curLeftDatas == 0 then
		printError("sr---挑战 PsychicedTowerFmtView:_updataLeftItemListShow()  关卡 = " .. cfg.buffPlanId)
	end

	self:_updataRightInfoShow()
end

function PsychicedTowerFmtView:_updataRightInfoShow()
	self._curRightDatas = {}

	self._leftListSR:ReloadData()

	local allScore = 0

	if self._curLeftDatas == nil or #self._curLeftDatas == 0 then
		self:updateStar(self._nowStar, allScore)
		self._rightListSR:ReloadData()
		MoonKingModel.instance:setChooseBuff()

		return
	end

	local cfg
	local tragetList = {}

	for i = 1, #self._curLeftDatas do
		if self._curLeftDatas[i] and checknumber(self._curLeftDatas[i].curIndex) > 0 and self._curLeftDatas[i].groupList then
			if self._curLeftDatas[i].groupList[self._curLeftDatas[i].curIndex] then
				allScore = allScore + self._curLeftDatas[i].groupList[self._curLeftDatas[i].curIndex].starNum

				table.insert(self._curRightDatas, {
					starNum = self._curLeftDatas[i].groupList[self._curLeftDatas[i].curIndex].starNum,
					name = self._curLeftDatas[i].groupList[self._curLeftDatas[i].curIndex].name,
					buffDesc = self._curLeftDatas[i].groupList[self._curLeftDatas[i].curIndex].buffDesc,
					optionId = self._curLeftDatas[i].groupList[self._curLeftDatas[i].curIndex].buffLevel,
					optionGroup = self._curLeftDatas[i].groupList[self._curLeftDatas[i].curIndex].buffType,
					curTime = self._curLeftDatas[i].curTime
				})
				table.insert(tragetList, {
					buffType = self._curLeftDatas[i].groupList[self._curLeftDatas[i].curIndex].buffType,
					buffLevel = self._curLeftDatas[i].groupList[self._curLeftDatas[i].curIndex].buffLevel
				})
			end
		end
	end

	self:updateStar(self._nowStar, allScore)
	GameUtil.SetActive(self._stateImaGo, allScore > self._bestScore)

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

	PsychicedTowerModel.instance:setChooseBuff(tragetList)
end

function PsychicedTowerFmtView:_UpdateLeftCell(view, cell, data)
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
		list.starGo = goutil.findChild(go, "star")
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

				moshiList[i].scoreTxt.text = tostring(info.starNum)

				self:updateStar(moshiList[i].starGo, info.starNum)

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

function PsychicedTowerFmtView:_onClickBuffItemBtn(groupId, index)
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

function PsychicedTowerFmtView:_UpdateRightCell(view, cell, data)
	local scoreTxt = goutil.findChildTextComponent(cell, "scoreTxt")
	local starGo = goutil.findChild(cell, "star")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local descTxt = goutil.findChildTextComponent(cell, "descTxt")
	local deleteBtnGo = goutil.findChild(cell, "deleteBtn")

	GameUtil.asBtn(deleteBtnGo):RemoveClickListener()

	scoreTxt.text = tostring(data.starNum)

	self:updateStar(starGo, data.starNum)

	nameTxt.text = data.name

	nameTxt.gameObject:GetComponent("UITextColorChange"):SetState(data.optionId - 1)

	descTxt.text = data.buffDesc

	if checknumber(data.optionGroup) > 0 then
		deleteBtnGo:SetActive(true)
		GameUtil.asBtn(deleteBtnGo):AddClickListener(function()
			self:_onClickBuffMinusBtn(data.optionGroup)
		end)
	else
		deleteBtnGo:SetActive(false)
	end
end

function PsychicedTowerFmtView:_onClickBuffMinusBtn(groupId)
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

function PsychicedTowerFmtView:updateStar(starGo, starNum)
	local maxFloor = math.floor(starNum / 2)
	local maxCeil = math.ceil(starNum / 2)

	for i = 1, starGo.transform.childCount do
		local go = goutil.findChild(starGo, "star_" .. i)
		local imgChange = go:GetComponent(ComponentType.UIImageSpriteChange)

		GameUtil.SetActive(go, i <= maxCeil)

		if maxFloor < i then
			imgChange:SetState(2)
		else
			imgChange:SetState(0)
		end
	end
end

function PsychicedTowerFmtView:_onClickArrowBtn()
	self._isOpenView = not self._isOpenView

	if self._isOpenView then
		self._viewClickGo:SetActive(true)
		self._allInfoGo:SetActive(true)
		Framework.TransformUtil.SetLocalScale(self._arrowTran, 1, 1, 1)
		UnityTweens.TweenPosition.StartTween(self._viewBgGo, Vector3.New(470, 80, 0), Vector3.New(-330, 80, 0), 0.4, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
	else
		self._viewClickGo:SetActive(false)
		Framework.TransformUtil.SetLocalScale(self._arrowTran, -1, 1, 1)

		local tweenPos = UnityTweens.TweenPosition.StartTween(self._viewBgGo, Vector3.New(-330, 80, 0), Vector3.New(470, 80, 0), 0.4, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)

		tweenPos:AddListener(function()
			if not self._isOpenView then
				self._allInfoGo:SetActive(false)
			end
		end)
	end
end

function PsychicedTowerFmtView:_onClickReset()
	PsychicedTowerModel.instance:setChooseBuff({})
	self:_updataLeftItemListShow()
end

return PsychicedTowerFmtView
