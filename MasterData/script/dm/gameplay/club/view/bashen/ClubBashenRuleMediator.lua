-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/bashen/ClubBashenRuleMediator.lua

ClubBashenRuleMediator = class("ClubBashenRuleMediator", DmPopupViewMediator, _M)

function ClubBashenRuleMediator:initialize()
	super.initialize(self)
end

function ClubBashenRuleMediator:dispose()
	super.dispose(self)
end

function ClubBashenRuleMediator:onRegister()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.dailyReset)
	super.onRegister(self)
end

function ClubBashenRuleMediator:enterWithData(data)
	self._main = self:getView():getChildByName("main")

	local bgNode = self._main:getChildByFullName("bg")

	self:bindWidget(bgNode, PopupNormalWidget, {
		ignoreWhiteBg = true,
		ignoreBtnBg = true,
		btnHandler = bind1(self.onClickClose, self),
		title = Strings:get("EightPieceText27"),
		bgSize = {
			538,
			width = 950
		}
	})
	bgNode:offset(-60, 0)

	self._listView = self._main:getChildByName("listview")

	self._listView:setScrollBarEnabled(false)
	self._listView:offset(0, -10)

	self._descClone = self:getView():getChildByName("descclone")

	self._descClone:setVisible(false)
	self:setupView()
end

function ClubBashenRuleMediator:setupView()
	local ruleList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "EightPieceRule", "content")

	if ruleList then
		for _, str in pairs(ruleList) do
			self:addDescPanel(Strings:get(str, {
				fontName = TTF_FONT_BOLD
			}))
		end
	end

	local rewardTitlePanel = self:getView():getChildByName("reward_title_panel")

	rewardTitlePanel:removeFromParent(false)
	self._listView:pushBackCustomItem(rewardTitlePanel)

	local bashenRewardList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BaShenRewardShowOrder", "content")
	local rewardPanel = self:getView():getChildByName("reward_panel")

	rewardPanel:setVisible(false)

	local index = 0

	for k, bashenReward in pairs(bashenRewardList) do
		local config = ConfigReader:getRecordById("BaShen", bashenReward)

		assert(config ~= nil, "bashen config is nil")

		local rewardPanelCell = rewardPanel:clone()

		rewardPanelCell:setVisible(true)

		local gemNumLabel = rewardPanelCell:getChildByName("gem_num")

		if not config.Amount then
			gemNumLabel:setString("x" .. config.Amount)

			local gemImage = rewardPanelCell:getChildByName("gem")
			local itemConfig = ConfigReader:getRecordById("ItemConfig", config.Item)

			gemImage:loadTexture(itemConfig.Icon, ccui.TextureResType.plistType)

			local rewardId = config.Reward
			local rewards = ConfigReader:getDataByNameIdAndKey("Reward", rewardId, "Content")

			if rewards then
				for i = 1, 3 do
					local rewardBg = rewardPanelCell:getChildByName("reward_" .. i)
					local rewardNumLabel = rewardBg:getChildByName("num")

					if rewards[i] then
						local icon = IconFactory:createRewardIcon(rewards[i], {
							ignoreAnim = true,
							showAmount = false,
							isWidget = true
						})

						IconFactory:bindTouchHander(icon, IconTouchHandler:new(self, {
							isWidget = true
						}), rewards[i], {
							needDelay = true
						})
						icon:setScale(0.6)
						icon:addTo(rewardBg):center(rewardBg:getContentSize())

						local rewardNum = rewards[i].amount

						if rewardNum >= 1000 then
							rewardNum = string.format(Strings:get("Number_TenThousand", {
								num = rewardNum / 1000
							}))
						end

						rewardNumLabel:setString("X" .. rewardNum)
					else
						rewardBg:setVisible(false)
					end
				end
			end

			self._listView:pushBackCustomItem(rewardPanelCell)

			index = index + 1

			local bg = index % 2 == 0 and "bd_bg_xxt_1.png" or "bd_bg_xxt_2.png"

			dump(bg, " bg @@@ ")
			rewardPanel:getChildByFullName("Image_bg"):loadTexture(bg, 1)
		end
	end

	self:addDescPanel(Strings:get("EightPieceText47", {
		fontName = TTF_FONT_BOLD
	}))
end

function ClubBashenRuleMediator:addDescPanel(desc)
	local panel = self._descClone:clone()
	local panelSize = panel:getContentSize()

	panel:setVisible(true)

	local descLabel = ccui.RichText:createWithXML(desc, {})

	descLabel:setAnchorPoint(cc.p(0.5, 0.5))
	descLabel:ignoreContentAdaptWithSize(false)
	descLabel:renderContent(self._descClone:getContentSize().width, 0)

	local labelSize = descLabel:getContentSize()

	panel:setContentSize(cc.size(panelSize.width + 5, 10 + labelSize.height))
	descLabel:addTo(panel):center(panel:getContentSize()):offset(0, 0)
	self._listView:pushBackCustomItem(panel)
end

function ClubBashenRuleMediator:dailyReset()
	self:close()
end

function ClubBashenRuleMediator:onClickClose(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end
