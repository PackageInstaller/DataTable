-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialchallenge/view/ResCopyView.lua

module("logic.extensions.materialchallenge.view.ResCopyView", package.seeall)

local ResCopyView = class("ResCopyView", ViewComponent)

function ResCopyView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._goldBarCon = self:getGo("goldBarCon")
	self._tableview = self:getGo("scrollList"):GetComponent("UITableview")
	self._tableCell = self:getGo("scrollList/item")

	self._tableCell:SetActive(false)

	self._goldenDiamond = self:getGo("goldenDiamond")
	self.itemGDC = self:getGo("goldenDiamond/item")
	self.showTip = self:getTxt("goldenDiamond/showTip")
	self.colorChange = self:getGo("goldenDiamond/showTip"):GetComponent("UITextColorChange")
	self._doubleGoldDiamond = self:getGo("double/goldDiamond")
	self._txtDoubleGDNum = self:getTxt("double/goldDiamond/txtNum")
	self._baseDouble = self:getGo("double/baseDouble")
	self._txtBaseDouble = self:getTxt("double/baseDouble/txtNum")
end

function ResCopyView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function ResCopyView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function ResCopyView:onEnter()
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor)
	GlobalDispatcher:addListener(GlobalNotify.MCLG_GetRewardMultiplyTimesRes, self._MCLG_GetRewardMultiplyTimesRes, self)
	GlobalDispatcher:addListener(GlobalNotify.MCLG_NotifyBaseMultiplyTimesChangeRes, self._updateBaseUseTimes, self)
	MaterialChallengeController.instance:sendMCLG_GetRewardMultiplyTimesReq()
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)
	self:_refreshResScrollList()
	self:_setGoldDiamond()
	self:_setBaseDouble()
end

function ResCopyView:_setGoldDiamond()
	self.isUserOfGDC = GoldenDiamondCardModel.instance.isUser

	if not self.isUserOfGDC then
		goutil.setActive(self._goldenDiamond, true)
		goutil.setActive(self._doubleGoldDiamond, false)
		uGuiUtil.setRawImageGrayState(self.itemGDC, not self.isUserOfGDC)
		self.colorChange:SetState(self.isUserOfGDC and 0 or 1)

		self.showTip.text = "激活金钻特权冒险幻境每日前10次扫荡掉落翻倍"
	else
		goutil.setActive(self._goldenDiamond, false)
		goutil.setActive(self._doubleGoldDiamond, true)

		local leftTime, totalTime = GoldenDiamondCardModel.instance:getLeftTimeOfPrivilege(GoldenDiamondCardModel.PrivilegeType.ResCopySweepDouble)

		if leftTime > 0 then
			if not ColorConst.Green then
				local colorStr = ColorConst.Red

				self._txtDoubleGDNum.text = string.format("今日剩余次数<color=#%s>%d</color>次", colorStr, leftTime)
			end
		end
	end
end

function ResCopyView:_setBaseDouble()
	local curUseCount = MaterialChallengeModel.instance:getBaseUseTimesById()
	local maxUseCount = MaterialChallengeConfig.instance:getDailyDoubleTimes()
	local leftTime = maxUseCount - curUseCount

	if leftTime > 0 then
		if not ColorConst.Green then
			local colorStr = ColorConst.Red

			self._txtBaseDouble.text = string.format("今日剩余次数<color=#%s>%d</color>次", colorStr, leftTime > 0 and leftTime or 0)
		end
	end
end

function ResCopyView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.MCLG_GetRewardMultiplyTimesRes, self._MCLG_GetRewardMultiplyTimesRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.MCLG_NotifyBaseMultiplyTimesChangeRes, self._updateBaseUseTimes, self)
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = {}

	self._tableview:UnRegisterAllCallbacks()
end

function ResCopyView:_onClickClose()
	self:close()
end

function ResCopyView:_refreshResScrollList()
	self._curViewDatas = {}

	local chapters = MaterialChallengeConfig.instance:getChapters()

	for i, vCfg in ipairs(chapters) do
		local element = {}

		element.index = i
		element.cfg = vCfg
		element.isLock = not MaterialChallengeModel.instance:isChapterUnlock(vCfg.chapterId)
		self._curViewDatas[#self._curViewDatas + 1] = element
	end

	table.sort(self._curViewDatas, function(a, b)
		return a.cfg.sortId < b.cfg.sortId
	end)
	self._tableview:ReloadData()
end

function ResCopyView:_numInView()
	return #self._curViewDatas
end

function ResCopyView:_cellSize(view, idx)
	return 354, 451
end

function ResCopyView:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	cell.index = index

	self:_updateCell(view, cell, data)

	return cell
end

function ResCopyView:_updateCell(view, cell, data)
	local idx = cell.index + 1
	local component = ResChapterItem.AddOnce(cell.gameObject)

	component:init(idx, data, self)
end

function ResCopyView:_clearTableview(cell)
	local component = ResChapterItem.AddOnce(cell.gameObject)

	component:reset()
end

function ResCopyView:_MCLG_GetRewardMultiplyTimesRes(msg)
	self:_refreshResScrollList()
	self:_setBaseDouble()
end

function ResCopyView:_updateBaseUseTimes()
	self:_setBaseDouble()
end

return ResCopyView
