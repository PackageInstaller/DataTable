-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/view/GalleryPartnerRewardMediator.lua

GalleryPartnerRewardMediator = class("GalleryPartnerRewardMediator", DmPopupViewMediator, _M)

GalleryPartnerRewardMediator:has("_gallerySystem", {
	is = "r"
}):injectWith("GallerySystem")

local kBtnHandlers = {}
local kTitle = {
	"GELLARY_CollectUI_WNSXJ",
	"GELLARY_CollectUI_XD",
	"GELLARY_CollectUI_BSNCT",
	"GELLARY_CollectUI_DWH",
	"GELLARY_CollectUI_MNJH",
	"GELLARY_CollectUI_SMZS"
}

function GalleryPartnerRewardMediator:initialize()
	super.initialize(self)
end

function GalleryPartnerRewardMediator:dispose()
	super.dispose(self)
end

function GalleryPartnerRewardMediator:onRemove()
	super.onRemove(self)
end

function GalleryPartnerRewardMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_GALLERY_BOX_GET_SUCC, self, self.onGalleryBoxGetSucc)

	self._main = self:getView():getChildByName("main")
	self._bottomTip = self._main:getChildByName("bottomTip")

	self._bottomTip:setVisible(true)

	self._cellClone = self._main:getChildByName("cellClone")

	self._cellClone:setVisible(false)
end

function GalleryPartnerRewardMediator:enterWithData(data)
	self._partyType = data.partyType
	self._rewardData = self._gallerySystem:getRewardDataByType(self._partyType)
	self._rewardStatusData = self._gallerySystem:getRewardStatusByType(self._partyType)

	self:setUi()

	local bgNode = self:getView():getChildByFullName("main.bgNode")
	local title = Strings:get(kTitle[data.tabType])
	local title1 = Strings:get("UITitle_EN_Jiangli")

	self:bindWidget(bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = title,
		title1 = title1,
		bgSize = {
			width = 736,
			height = 374
		},
		fontSize = getCurrentLanguage() ~= GameLanguageType.CN and 40 or nil
	})
end

function GalleryPartnerRewardMediator:setUi()
	local tableViewPanel = self._main:getChildByName("tableView")

	tableViewPanel:removeAllChildren()

	local width = self._cellClone:getContentSize().width
	local height = self._cellClone:getContentSize().height

	local function scrollViewDidScroll(view)
		self._isReturn = false

		local offY = view:getContentOffset().y

		if offY == 0 then
			self._bottomTip:setVisible(false)
		else
			self._bottomTip:setVisible(true)
		end
	end

	local function cellSizeForTable(table, idx)
		return width, height
	end

	local function numberOfCellsInTableView(table)
		return #self._rewardData
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		self:createTeamCell(cell, idx + 1)

		return cell
	end

	local tableView = cc.TableView:create(tableViewPanel:getContentSize())

	self._tableView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	tableViewPanel:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:setMaxBounceOffset(20)
	tableView:reloadData()
end

function GalleryPartnerRewardMediator:createTeamCell(cell, index)
	cell:removeAllChildren()

	local rewardData = self._rewardData[index]
	local panel = self._cellClone:clone()

	panel:setVisible(true)
	panel:setPosition(cc.p(0, 0))
	panel:addTo(cell)

	local progress = panel:getChildByName("progress")

	progress:setString(((self._rewardStatusData[rewardData.targetType] or nil) and self._rewardStatusData[rewardData.targetType]) .. "/" .. rewardData.targetNum)

	local nameLabel = panel:getChildByName("name")

	nameLabel:setString(rewardData.name)

	local descLabel = panel:getChildByName("desc")

	descLabel:setString(rewardData.desc)

	local rewardBtn = panel:getChildByFullName("rewardBtn")

	rewardBtn:setSwallowTouches(false)
	rewardBtn:addTouchEventListener(function(sender, eventType)
		self:onClickReward(sender, eventType, index)
	end)

	local status = rewardData.status

	rewardBtn:setTouchEnabled(status == TaskStatus.kFinishNotGet)
	rewardBtn:setVisible(status ~= TaskStatus.kGet)

	local str = Strings:get("GALLERY_UnAchieve")
	local imageFile = "common_btn_s02.png"

	if status == TaskStatus.kFinishNotGet then
		str = Strings:get("CUSTOM_REWARD_CAN_RECEIVE")
		imageFile = "common_btn_s01.png"
	end

	rewardBtn:getChildByFullName("name"):setString(str)
	rewardBtn:loadTextureNormal(imageFile, 1)
	rewardBtn:loadTexturePressed(imageFile, 1)

	local done = panel:getChildByFullName("done")

	done:setVisible(status == TaskStatus.kGet)
	progress:setVisible(status ~= TaskStatus.kGet)

	local rewardId = rewardData.rewardId
	local rewards = RewardSystem:getRewardsById(rewardId)

	for i = 1, 3 do
		local node = panel:getChildByFullName("node_" .. i)

		node:removeChildByName("RewardNode")
		node:setVisible(false)

		if rewards[i] then
			node:setVisible(true)

			local reward = rewards[i]
			local info = RewardSystem:parseInfo(reward)
			local icon = IconFactory:createPic(info, {
				largeIcon = true
			})

			icon:addTo(node)
			icon:setName("RewardNode")
			icon:setScale(0.5)
			node:getChildByFullName("countBg"):setLocalZOrder(2)
			node:getChildByFullName("count"):setLocalZOrder(2)
			node:getChildByFullName("count"):setString(reward.amount or 0)
		end
	end
end

function GalleryPartnerRewardMediator:onClickReward(sender, eventType, index)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
	elseif eventType == ccui.TouchEventType.ended and self._isReturn then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local rewardData = self._rewardData[index]

		if rewardData.status == TaskStatus.kUnfinish or rewardData.status == TaskStatus.kGet then
			local view = self:getInjector():getInstance("GalleryRewardBoxView")
			local info = {
				rewardId = rewardData.rewardId
			}

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, info))
		else
			local params = {
				partyId = self._partyType,
				partyRewardId = rewardData.galleryRewardId
			}

			self._gallerySystem:requestGalleryPartyReward(params)
		end
	end
end

function GalleryPartnerRewardMediator:onGalleryBoxGetSucc(event)
	self._rewardData = self._gallerySystem:getRewardDataByType(self._partyType)

	self._tableView:reloadData()

	local data = event:getData()
	local rewards = data.data
	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, {
		rewards = rewards
	}))
end

function GalleryPartnerRewardMediator:onClickClose()
	self:close()
end
