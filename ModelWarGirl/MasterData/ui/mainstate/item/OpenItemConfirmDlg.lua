-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Item\\OpenItemConfirmDlg.lua

local ResRandClient = require("ClientData/ResRandClient")
local strClassName = "GridOpenConfirmChild"
local GridOpenConfirmChild = Class(strClassName, UIControls.Child)

function GridOpenConfirmChild:ctor()
	self:initUI()
end

function GridOpenConfirmChild:initUI()
	self.imgIcon = UIControls.Image(self, "Icon")
	self.txtNum = UIControls.Label(self, "TxtNum")
end

function GridOpenConfirmChild:setOpenItem(item, useCount)
	if item then
		self.item = item
	end

	useCount = useCount or 1

	local iconPath = self.item:getIconPath()

	if iconPath then
		self.imgIcon:setImage(iconPath[1], iconPath[2])
	end

	self.txtNum:setText(ClientUtils.getNumShortStr(self.item.num * useCount))
end

local NumControlPanel = require("UI/MainState/Item/NumControlPanel")
local ResItem = require("ClientData/ResItem")
local ResClientHardCode = require("ClientData/ResClientHardCode")
local UIControls = UIControls
local strClassName = "OpenItemConfirmDlg"
local OpenItemConfirmDlg = Class(strClassName, UIControls.Window)

function OpenItemConfirmDlg:ctor()
	self:initUI()
end

function OpenItemConfirmDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnDeny")

	self.btnClose:addEventClick(self.onCloseClick)

	self.textNum = UIControls.Label(self, "BgPanel/TextNum")
	self.btnUse = UIControls.Button(self, "BgPanel/BtnConfirm", "Text")

	self.btnUse:addEventClick(self.onUseClick)

	self.gridOpenItemList = {}
	self.panelDes = UIControls.Panel(self, "DesPanel")
	self.panelIcon = UIControls.Panel(self, "IconPanel")
	self.numPanel = NumControlPanel(self, "BgPanel/NumPanel")
	self.numPanel.mEventNumChanged = Slot(self.onNumChanged, self)
	self.panelBlessing = UIControls.Panel(self, "BgPanel/BlessingPanel")
	self.txtBlessing = UIControls.Label(self, "BgPanel/BlessingPanel/TextBlessing")
	self.btnRandom = UIControls.Button(self, "BgPanel/BlessingPanel/BtnRandom")

	self.btnRandom:addEventClick(self.onBtnRandomClick)
end

function OpenItemConfirmDlg:onShow(item, confirmCB, needIgnoreItemUse)
	self.item = item
	self.mConfirmCB = confirmCB
	self.needIgnoreItemUse = needIgnoreItemUse
	self.grid = UIControls.ItemGridChild(self, "BgPanel/ItemPanel", "System/Common/Grid/GridMaterialItem")
	self.grid.mEnableTips = false

	if self.item.resData.extend_args1 and self.item.subType == Const.ITEM_STYPE_RAND_GIFT_PKG then
		local maxHaveNum = self.item.num
		local blankNum = 999
		local maxNotice = ""

		if self.item.resData.extend_args1 == 1 then
			blankNum = CurAvatar:getHeroRemainBlankNum()
			maxNotice = Lang.get(3616)
		end

		if maxHaveNum <= blankNum then
			self.numPanel:onShow(maxHaveNum, maxHaveNum, Lang.get(983))
		else
			self.numPanel:onShow(blankNum, blankNum, Lang.get(983), maxNotice)
		end
	else
		self.numPanel:onShow(self.item.num, self.item.num, Lang.get(588))
	end

	self.grid:setVisible(true)
	self.textNum:setText(string.format(Lang.get(30234), ClientUtils.getNumShortStr(CurAvatar:getItemNumById(self.item.id))))
	self.grid:setObj(BaseObject.GetObject(self.item.id))

	if self.item.subType == Const.ITEM_STYPE_RAND_DEPOSIT_GIFT_PKG then
		self.panelDes:setVisible(true)
		self.panelIcon:setVisible(true)

		for idx, itemId in ipairs(self.item.resData.extend_args3) do
			local awards = ResRandClient[CurAvatar.mainStageCur.deposit_assgin_award] or {}
			local awardIDs = awards.show_ids or {}
			local awardNums = awards.show_nums or {}

			for awardIdx, awardItemId in ipairs(awardIDs) do
				if awardItemId == itemId then
					if not self.gridOpenItemList[idx] then
						self.gridOpenItemList[idx] = GridOpenConfirmChild(self, "BgPanel/IconPanel", "System/Common/Grid/GridOpenConfirmItem", 0, 0, true)
					end

					local awardNumPerSixSec = awardNums[awardIdx] or 1
					local awardNum = math.floor(self.item.resData.extend_args1 * awardNumPerSixSec / 6)
					local openItem = BaseObject.GetObject(itemId, awardNum)

					self.gridOpenItemList[idx]:setOpenItem(openItem, self.nowNum)
				end
			end
		end
	else
		self.panelDes:setVisible(false)
		self.panelIcon:setVisible(false)
	end
end

function OpenItemConfirmDlg:showBlessingPanel(randFunc)
	self.panelBlessing:setVisible(true)

	self.mRandFunc = randFunc

	local id, content = randFunc(self.item)

	self.param = id or 1

	if content then
		self.txtBlessing:setText(content)
	end
end

function OpenItemConfirmDlg:setNumLimit(maxNum, initNum)
	self.numPanel:setNumLimit(maxNum, initNum)
end

function OpenItemConfirmDlg:onNumChanged(num)
	self.nowNum = num

	for i, v in ipairs(self.gridOpenItemList) do
		self.gridOpenItemList[i]:setOpenItem(nil, self.nowNum)
	end
end

function OpenItemConfirmDlg:onUseClick()
	if self.nowNum <= 0 then
		MsgManager.notice(Lang.get(30497))
	else
		local use = {}

		use.data = {}
		use.data.id = self.item.id
		use.data.num = self.nowNum

		if self.param then
			use.param = self.param
		end

		if not self.needIgnoreItemUse then
			if self.item.subType == Const.ITEM_STYPE_RED_PACKET then
				local type = ResClientHardCode[13].value[1]

				if type == 2 then
					local ui = UIManager.getUI("redPacketFireWorkDlg", true)

					ui:playEffect(true)
				end
			end

			RPC.itemUse({
				use
			})
		end

		self:setVisible(false)

		if self.mConfirmCB then
			self.mConfirmCB(use)
		end
	end
end

function OpenItemConfirmDlg:onBtnRandomClick(...)
	if self.mRandFunc then
		local id, content = self.mRandFunc(self.item)

		self.txtBlessing:setText(content or "")

		self.param = id or 1
	end
end

function OpenItemConfirmDlg:onCloseClick()
	self:setVisible(false)
end

return OpenItemConfirmDlg
