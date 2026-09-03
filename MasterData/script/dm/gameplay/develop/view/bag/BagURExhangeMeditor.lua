-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/bag/BagURExhangeMeditor.lua

BagURExhangeMeditor = class("BagURExhangeMeditor", DmPopupViewMediator, _M)

BagURExhangeMeditor:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local URmap_Shop_TransItem = ConfigReader:getDataByNameIdAndKey("ConfigValue", "URmap_Shop_TransItem", "content")
local kBtnHandlers = {
	["main.minusbtn"] = {
		ignoreClickAudio = true,
		func = "onSubClicked"
	},
	["main.addbtn"] = {
		ignoreClickAudio = true,
		func = "onAddClicked"
	},
	["main.maxbtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onMaxClicked"
	}
}

function BagURExhangeMeditor:initialize()
	super.initialize(self)
end

function BagURExhangeMeditor:dispose()
	super.dispose(self)
end

function BagURExhangeMeditor:onRegister()
	super.onRegister(self)

	self._bagSystem = self._developSystem:getBagSystem()
	self._heroSystem = self._developSystem:getHeroSystem()
	self._btnWidget = self:bindWidget("main.btn_ok", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onExchangeClicked, self)
		}
	})

	bindWidget(self, "main.bg", PopupNormalWidget, {
		title1 = "",
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onBackClicked, self)
		},
		title = Strings:get("Shop_URMap_Transform_Title"),
		bgSize = {
			width = 837,
			height = 573
		}
	})
end

function BagURExhangeMeditor:enterWithData(data)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._sourceId = data.sourceId
	self._targetId = URmap_Shop_TransItem.itemID
	self._curEntry = self._bagSystem:getEntryById(self._sourceId)

	self:refreshData()
	self:createView()
	self:refreshView()
	self:refreshSlider()
end

function BagURExhangeMeditor:refreshData()
	self._max = self._curEntry.count

	if self._bagSystem:checkCanUseCompose(self._curEntry.item) then
		self._max = self._curEntry.count - 1
	end
end

function BagURExhangeMeditor:createView()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._infoPanel = self._mainPanel:getChildByFullName("infoPanel")
	self._countlabel = self._mainPanel:getChildByFullName("countlabel")
	self._sourceIconPanel = self._mainPanel:getChildByFullName("debris1panel")
	self._targetIconPanel = self._mainPanel:getChildByFullName("debris2panel")

	self._countlabel:setOpacity(86)
	self._countlabel:setString(Strings:get("Shop_URMap_Untransform_Tips_Desc2"))
	self._countlabel:setVisible(self._bagSystem:checkCanUseCompose(self._curEntry.item))

	self._slider = self._mainPanel:getChildByFullName("slider")

	self._slider:setScale9Enabled(true)
	self._slider:setCapInsets(cc.rect(43, 2, 32, 2))
	self._slider:setCapInsetsBarRenderer(cc.rect(1, 1, 1, 1))
	self._slider:addEventListener(function(sender, eventType)
		if eventType == ccui.SliderEventType.percentChanged then
			if self._curCount == 0 then
				self._slider:setPercent(0)
			else
				local percent = self._slider:getPercent()

				if percent == 0 then
					self._curCount = 1
				else
					local count = math.ceil(percent / 100 * self._max)

					self._curCount = math.min(count, self._max)
				end

				self:refreshView()
			end
		end
	end)

	self._curCount = self._max
end

function BagURExhangeMeditor:refreshSlider()
	self._slider:setPercent(self._curCount / self._max * 100)
end

function BagURExhangeMeditor:refreshView()
	self._sourceIconPanel:removeAllChildren()

	local icon = IconFactory:createItemIcon({
		id = self._sourceId
	}, {
		showAmount = true,
		isWidget = true
	})

	icon:addTo(self._sourceIconPanel):center(self._sourceIconPanel:getContentSize())
	icon:setAmount(self._curCount .. "/" .. self._max)

	local icon = IconFactory:createItemIcon({
		id = self._targetId
	}, {
		showAmount = true,
		isWidget = true
	})

	self._targetIconPanel:removeAllChildren()
	icon:addTo(self._targetIconPanel):center(self._targetIconPanel:getContentSize())
	icon:setNotEngouhState(false)
	icon:setAmount(self._curCount * URmap_Shop_TransItem.transNum)
end

function BagURExhangeMeditor:onBackClicked(sender, eventType)
	self:close()
end

function BagURExhangeMeditor:onExchangeClicked(sender, eventType)
	if self._curCount <= 0 then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Confirm", false)

	local sendParam = {}

	sendParam[self._sourceId] = self._curCount

	self._bagSystem:transferURScroll(sendParam, nil)
	self:close()
end

function BagURExhangeMeditor:onAddClicked(sender, eventType)
	self._curCount = self._curCount + 1

	if self._curCount > self._max then
		self._curCount = self._max
	end

	self:refreshView()
	self:refreshSlider()
end

function BagURExhangeMeditor:onSubClicked(sender, eventType)
	self._curCount = self._curCount - 1

	if self._curCount < 1 then
		self._curCount = 1
	end

	self:refreshView()
	self:refreshSlider()
end

function BagURExhangeMeditor:onMaxClicked(sender, eventType)
	self._curCount = self._max

	self:refreshView()
	self:refreshSlider()
end
