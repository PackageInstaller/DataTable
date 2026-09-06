-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddess/view/GoddessrankView.lua

module("logic.extensions.goddess.view.GoddessrankView", package.seeall)

local GoddessrankView = class("GoddessrankView", ViewComponent)

function GoddessrankView:ctor()
	GoddessrankView.super.ctor(self)

	self._curLeftDatas = nil
	self._choLeftIndex = 1
	self._curRightDatas = nil
	self._itemGroupList = {}
end

function GoddessrankView:bindEvents()
	GoddessrankView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function GoddessrankView:unbindEvents()
	GoddessrankView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function GoddessrankView:onExit()
	GoddessrankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GoddessViewRankRes, self._updataRankItemListShow, self)

	self._curLeftDatas = nil
	self._choLeftIndex = 1
	self._curRightDatas = nil

	for k, v in pairs(self._itemGroupList) do
		v:dispose(function(item)
			MaterialMgr.resetAll(item.mainGO)
		end)
	end
end

function GoddessrankView:destroyUI()
	GoddessrankView.super.destroyUI(self)
end

function GoddessrankView:buildUI()
	GoddessrankView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._leftListSR = self:getGo("tabListSR"):GetComponent("UITableview")
	self._leftItem = self:getGo("tabItme")

	self._leftItem:SetActive(false)

	local rightInfoGo = self:getGo("rightInfoGo")

	self._rightListSR = goutil.findChild(rightInfoGo, "rankListSR"):GetComponent("UITableview")
	self._rightItem = goutil.findChild(rightInfoGo, "rankItem")

	self._rightItem:SetActive(false)

	self._emptyGo = goutil.findChild(rightInfoGo, "emptyGo")

	local myRankGo = goutil.findChild(rightInfoGo, "myRankGo")

	self._myRankTxt = goutil.findChildTextComponent(myRankGo, "myRankTxt")
	self._rankDescTxt = goutil.findChildTextComponent(myRankGo, "rankDescTxt")
	self._myRankTxt.text = ""
	self._rankDescTxt.text = GoddessConfig.instance:getCommonValue("RANK_TIP")

	self._emptyGo:SetActive(false)
	self:registCallbacks()
end

function GoddessrankView:registCallbacks()
	self._leftListSR:RegisterCallback(self._LeftInView, function()
		return 170, 65
	end, self._LeftAtIndex, self)
	self._leftListSR:RegisterUpdateCellCallback(self._OnLeftCellUpdate)
	self._rightListSR:RegisterCallback(self._RightInView, function()
		return 1070, 110
	end, self._RightAtIndex, self)
	self._rightListSR:RegisterUpdateCellCallback(self._OnRightCellUpdate)
end

function GoddessrankView:_LeftInView()
	if not self._curLeftDatas then
		return 0
	end

	return #self._curLeftDatas
end

function GoddessrankView:_LeftAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._leftItem)

	local data = self._curLeftDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_UpdateLeftCell(view, cell, data)

	return cell
end

function GoddessrankView:_OnLeftCellUpdate(view, cell)
	local index = cell.index
	local data = self._curLeftDatas[index + 1]

	cell.data = index + 1

	self:_UpdateLeftCell(view, cell, data)
end

function GoddessrankView:_RightInView()
	if not self._curRightDatas then
		return 0
	end

	return #self._curRightDatas
end

function GoddessrankView:_RightAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._rightItem)

	local data = self._curRightDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_UpdateRightCell(view, cell, data)

	return cell
end

function GoddessrankView:_OnRightCellUpdate(view, cell)
	local index = cell.index
	local data = self._curRightDatas[index + 1]

	cell.data = index + 1

	self:_UpdateRightCell(view, cell, data)
end

function GoddessrankView:onEnter()
	GoddessrankView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.GoddessViewRankRes, self._updataRankItemListShow, self)

	self._activityId = GoddessModel.instance:getActId()

	GoddessAgent.instance:sendPM_GoddessViewRankReq(self._activityId)

	self._rankPrizeCfgs = GoddessConfig.instance:getRankCfgsByActId(self._activityId) or {}
	self._curLeftDatas = {
		{
			name = "送花榜"
		}
	}
	self._choLeftIndex = 1

	self._leftListSR:ReloadData()
	self:_updataRankItemListShow()
end

function GoddessrankView:_updataRankItemListShow(rankInfo)
	self._curRightDatas = {}

	if rankInfo then
		self._curRightDatas = rankInfo.rankList
		self._myRankTxt.text = checknumber(rankInfo.myRank) <= 0 and "未上榜" or tostring(rankInfo.myRank)
	else
		self._myRankTxt.text = "未上榜"
	end

	if self._curRightDatas == nil or #self._curRightDatas == 0 then
		self._emptyGo:SetActive(true)
	else
		self._emptyGo:SetActive(false)
	end

	self._rightListSR:ReloadData()
end

function GoddessrankView:_UpdateLeftCell(view, cell, data)
	local iconIma = goutil.findChild(cell, "iconIma"):GetComponent("UIImageSpriteChange")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local lockGo = goutil.findChild(cell, "lockGo")

	GameUtil.asBtn(cell):RemoveClickListener()

	local index = cell.data

	if self._choLeftIndex == index then
		iconIma:SetState(1)
	else
		iconIma:SetState(0)
	end

	nameTxt.text = data.name

	lockGo:SetActive(false)
	GameUtil.asBtn(cell):AddClickListener(function()
		if self._choLeftIndex == index then
			return
		end

		self._choLeftIndex = index

		self._leftListSR:ReloadData()
	end, self)
end

function GoddessrankView:_UpdateRightCell(view, cell, data)
	local rankTxt = goutil.findChildTextComponent(cell, "rankTxt")
	local headGo = goutil.findChild(cell, "headGo")
	local itemcon = goutil.findChild(cell, "itemcon")
	local item = goutil.findChild(cell, "item")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local flowerTxt = goutil.findChildTextComponent(cell, "flowerTxt")
	local imgRankChange = goutil.findChild(cell, "imgRank"):GetComponent(ComponentType.UIImageSpriteChange)
	local proxy = HeadItemController.instance:setHeadCellByInfo(headGo, data.headInfo)

	if proxy then
		proxy:setCallBack(function()
			if data.headInfo.userId then
				self:onHeadClick(data.headInfo.userId, headGo)
			end
		end)
	end

	nameTxt.text = data.headInfo.userName
	flowerTxt.text = data.flowerNum

	local isTop3 = data.rank > 0 and data.rank <= 3

	goutil.setActive(imgRankChange.gameObject, isTop3)

	if not isTop3 then
		rankTxt.text = tostring(data.rank)
	else
		imgRankChange:SetState(data.rank - 1)

		rankTxt.text = ""
	end

	local itemGroup = self._itemGroupList[itemcon]

	if not itemGroup then
		itemGroup = ItemGroup.New(itemcon, item, nil, nil, true)
		self._itemGroupList[itemcon] = itemGroup
	end

	itemGroup:updateWithMoArray((self._rankPrizeCfgs[data.rank] or nil) and string.split(self._rankPrizeCfgs[data.rank].prize, "#"), function(item, cfgStr)
		MaterialMgr.setCellByCfg(cfgStr, item.mainGO)
	end)
end

function GoddessrankView:onHeadClick(userId, imgIcon)
	print("onHeadClick")
	FriendController.instance:showInfoView(userId, imgIcon)
end

return GoddessrankView
