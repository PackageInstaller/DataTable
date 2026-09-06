-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceAllBuffsView.lua

module("logic.extensions.rankrace.view.RankRaceAllBuffsView", package.seeall)

local RankRaceAllBuffsView = class("RankRaceAllBuffsView", ViewComponent)

function RankRaceAllBuffsView:buildUI()
	RankRaceAllBuffsView.super.buildUI(self)
	self:_initBuffNode()
	self:_initBuffView()

	self._btnClose = self:getBtn("BtnClose")
end

function RankRaceAllBuffsView:_initBuffNode()
	self._imgBuffIcon = self:getGo("DefenseBuff/Icon")
	self._buffName = self:getTxt("DefenseBuff/TxtBuffName")
	self._buffDesc = self:getTxt("DefenseBuff/TxtBuffDesc")
end

function RankRaceAllBuffsView:_initBuffView()
	self._buffsView = self:getGo("ScrollView"):GetComponent(typeof(UITableview))
	self._buffItem = self:getGo("BuffItem")

	self._buffItem:SetActive(false)
end

function RankRaceAllBuffsView:bindEvents()
	RankRaceAllBuffsView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._buffsView:RegisterCallback(self._numBuffsInView, nil, self._buffCellAtIndex, self)
end

function RankRaceAllBuffsView:unbindEvents()
	RankRaceAllBuffsView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._buffsView:UnRegisterAllCallbacks()
	self._buffsView:Travel(function(cell)
		local buffBtn = goutil.findChild(cell.gameObject, "Button")

		Framework.UIClickTrigger.Get(buffBtn):RemoveClickListener()
	end, nil)
end

function RankRaceAllBuffsView:onEnter()
	RankRaceAllBuffsView.super.onEnter(self)

	self._matchType = self:getFirstParam()
	self._currBuffId = self:getOpenParam()[2]
	self._buffDatas = RankRaceConfig.instance:getAllRankRaceBuffs()

	local currBuffId = self._currBuffId

	if not currBuffId or currBuffId == 0 then
		currBuffId = self._buffDatas[1].id
	end

	self._selectBuffId = currBuffId

	self:_updateBuff(currBuffId)
	self._buffsView:SetOffsetWithoutRefresh(0)
	self._buffsView:ReloadData()
end

function RankRaceAllBuffsView:onExit()
	self._matchType = nil
	self._selectBuffId = nil

	local bigImg = Framework.ImageBigBG.Get(self._imgBuffIcon)

	bigImg:ClearImage()
	self._buffsView:Travel(function(cell)
		local buffIcon = goutil.findChild(cell.gameObject, "Icon")
		local buffIconImg = Framework.ImageBigBG.Get(self._imgBuffIcon)

		buffIconImg:ClearImage()
	end, nil)
	RankRaceAllBuffsView.super.onExit(self)
end

function RankRaceAllBuffsView:_updateBuff(buffId)
	local buffCo = RankRaceConfig.instance:getRankRaceBuffCo(buffId)

	self._buffName.text = buffCo.name
	self._buffDesc.text = buffCo.desc

	uGuiUtil.setSpriteToImage(self._imgBuffIcon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getRankRaceBuffIconUrl(buffCo.icon))
end

function RankRaceAllBuffsView:_onClickBtnClose()
	self:close()
end

function RankRaceAllBuffsView:_numBuffsInView()
	return #self._buffDatas
end

function RankRaceAllBuffsView:_buffCellAtIndex(view, idx)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._buffItem)

	local data = self._buffDatas[idx + 1]
	local go = cell.gameObject
	local buffName = goutil.findChildTextComponent(go, "BuffName")
	local buffIcon = goutil.findChild(go, "Icon")
	local imgUp = goutil.findChild(go, "imgUp")
	local currBuff = goutil.findChild(go, "CurrBuff")
	local buffBtn = goutil.findChild(go, "Button")
	local selected = goutil.findChild(go, "Selected")
	local btn = Framework.UIClickTrigger.Get(buffBtn)

	buffName.text = data.name

	uGuiUtil.setSpriteToImage(buffIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getRankRaceBuffIconUrl(data.icon))
	imgUp:SetActive(self._currBuffId == data.id)
	currBuff:SetActive(self._currBuffId == data.id)
	selected:SetActive(self._selectBuffId == data.id)
	btn:RemoveClickListener()
	btn:AddClickListener(function()
		self._selectBuffId = data.id

		self:_updateBuff(self._selectBuffId)
		self._buffsView:Refresh()
	end, nil)

	return cell
end

return RankRaceAllBuffsView
