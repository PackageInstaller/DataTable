-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlestartanim/view/OtherBgInfoView.lua

module("logic.extensions.battlestartanim.view.OtherBgInfoView", package.seeall)

local OtherBgInfoView = class("OtherBgInfoView", ViewComponent)

function OtherBgInfoView:ctor()
	OtherBgInfoView.super.ctor(self)
end

function OtherBgInfoView:buildUI()
	OtherBgInfoView.super.buildUI(self)

	self._previewImg = self:getGo("preview/img")
	self.scrollerGo = self:getGo("anims/tableview")
	self.cellGo = self:getGo("anims/cell")
	self.scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self._txtNum = self:getTxt("state/txtNum")
end

function OtherBgInfoView:bindEvents()
	OtherBgInfoView.super.bindEvents(self)
end

function OtherBgInfoView:unbindEvents()
	OtherBgInfoView.super.unbindEvents(self)
end

function OtherBgInfoView:onEnter()
	OtherBgInfoView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.GetOtherUniquePropsRes, self._onGetOtherUniquePropsRes, self)

	self._curSelectItem = nil
	self._userId = self:getFirstParam()
	self._matType = MatType.HomePageBg

	BattleStartAnimController.instance:sendPM_GetOtherUniquePropsReq(self._matType, self._userId)
end

function OtherBgInfoView:onExit()
	OtherBgInfoView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GetOtherUniquePropsRes, self._onGetOtherUniquePropsRes, self)
	self.scrollList:dispose()
	self:_clearPreviewImg()
end

function OtherBgInfoView:_onGetOtherUniquePropsRes()
	self:_initScrollList()
end

function OtherBgInfoView:_initScrollList()
	self._cfgs = BattleStartAnimConfig.instance:getHomePageBgCfgList()

	local list = {}
	local initIndex = 1
	local curCount = 0
	local firstItem

	for i, v in ipairs(self._cfgs) do
		local item = {}

		item.index = i
		item.cfg = v
		item.state = BattleStartAnimModel.instance:getOtherState(self._matType, v.id)
		item.isSelect = item.state == BattleStartAnimModel.Using

		if item.isSelect then
			initIndex = i
		end

		if item.state ~= BattleStartAnimModel.Lock then
			table.insert(list, item)
		end

		if item.state >= BattleStartAnimModel.Unuse then
			curCount = curCount + 1
		end

		if i == 1 then
			firstItem = item
		end
	end

	if curCount == 0 then
		curCount = 1
		firstItem.state = BattleStartAnimModel.Using
		firstItem.isSelect = true
		initIndex = 1

		if #list == 0 then
			table.insert(list, firstItem)
		end
	end

	self.scrollList:reloadData(list)

	self._curSelectItem = list[initIndex]

	self:_setPreviewImage(self._cfgs[initIndex])

	local totalCount = #self._cfgs

	self._txtNum.text = string.format("已收集：%s/%s", curCount, totalCount)
end

function OtherBgInfoView:_updateSelectIndex(newIndex)
	local curViewDatas = self.scrollList:getData()

	for i, v in ipairs(curViewDatas) do
		v.isSelect = newIndex == v.index
	end

	self.scrollList:refresh()
end

function OtherBgInfoView:_updateCell(view, cell, data, tag)
	local img = goutil.findChild(cell, "img")
	local imgQuality = goutil.findChild(cell, "imgQuality")
	local lock = goutil.findChild(cell, "lock")
	local using = goutil.findChild(cell, "using")
	local select = goutil.findChild(cell, "select")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)

	btn:AddClickListener(function()
		self._curSelectItem = data

		self:_setPreviewImage(data.cfg)
		self:_updateSelectIndex(data.index)
	end)
	goutil.setActive(select, data.isSelect)
	goutil.setActive(lock, data.state == BattleStartAnimModel.Lock)
	goutil.setActive(using, data.state == BattleStartAnimModel.Using)

	txtName.text = data.cfg.name

	uGuiUtil.setSpriteToImage(img, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("playerinfobg", data.cfg.icon))
	uGuiUtil.setSpriteToImage(imgQuality, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("playerinfobg", data.cfg.qualityIcon))
end

function OtherBgInfoView:clearCell(cell)
	local img = goutil.findChild(cell, "img")
	local imgQuality = goutil.findChild(cell, "imgQuality")

	uGuiUtil.clearImage(img)
	uGuiUtil.clearImage(imgQuality)
end

function OtherBgInfoView:_setPreviewImage(cfg)
	if not cfg then
		return
	end

	uGuiUtil.setSpriteToImage(self._previewImg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("playerinfobg", cfg.previewIcon))
end

function OtherBgInfoView:_clearPreviewImg()
	uGuiUtil.clearImage(self._previewImg)
end

return OtherBgInfoView
