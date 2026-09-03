-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WordPeaceChoseBossMediator.lua

WordPeaceChoseBossMediator = class("WordPeaceChoseBossMediator", DmPopupViewMediator, _M)

WordPeaceChoseBossMediator:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")

function WordPeaceChoseBossMediator:initialize()
	super.initialize(self)
end

function WordPeaceChoseBossMediator:dispose()
	super.dispose(self)
end

function WordPeaceChoseBossMediator:onRegister()
	super.onRegister(self)
end

function WordPeaceChoseBossMediator:enterWithData(data)
	local widget = self:bindWidget("bg", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onCloseClicked, self)
		},
		title = Strings:get("ClubMapBoss_Chat_UI10"),
		title1 = Strings:get("ClubMapBoss_Chat_UI10")
	})

	self:getView():getChildByName("cancel"):addClickEventListener(function()
		self:onCloseClicked()
		AudioEngine:getInstance():playEffect("Se_Click_Cancle", false)
	end)
	self:getView():getChildByName("sure"):addClickEventListener(function()
		self:onClickOK()
	end)

	local allBoss = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMap_NineBoss", "content")
	local price = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_Bride_ChangeSpend", "content")

	self:getView():getChildByFullName("sure.text"):setString("x" .. price)

	local chatBossId = self._worldPeaceSystem:getWorldSwearChat():getChatBossId()

	self._allBoss = {}

	local count = 1

	for k, v in pairs(allBoss) do
		if v ~= chatBossId then
			local node = self:getView():getChildByName("node" .. count)

			if node then
				local bossInfo = ConfigReader:getRecordById("ClubMapBoss", v)
				local di = ccui.ImageView:create("asset/commonRaw/Frame_Actitity_Moren_di.png", 0)

				di:addTo(node)
				di:setScale(0.45)

				local xuanzhong = ccui.ImageView:create("asset/wordpeace/common_btn_xuanzhong.png", 0)

				xuanzhong:addTo(node)
				xuanzhong:setScale(2.8)
				xuanzhong:setName("select")

				local modelId = IconFactory:getRoleModelByKey("HeroBase", bossInfo.Hero)
				local headicon = IconFactory:createRoleIconSpriteNew({
					id = modelId
				})

				headicon:setScale(0.45)
				headicon:addTo(node)
				headicon:setTouchEnabled(false)

				local kuang = ccui.ImageView:create("asset/head/Frame_Actitity_Moren.png", 0)

				kuang:addTo(node)
				kuang:setScale(0.45)
				kuang:setTouchEnabled(true)
				kuang:setClickEffectUnVisible(true)
				xuanzhong:setVisible(false)
				kuang:addClickEventListener(function()
					self:handleSelect(node)
				end)

				self._allBoss[#self._allBoss + 1] = node
				node.bossId = v

				if k == 1 then
					self:handleSelect(node)
				end

				count = count + 1
			end
		end
	end

	local sure = self:getView():getChildByName("sure")
	local goldIcon = IconFactory:createResourcePic({
		id = CurrencyIdKind.kDiamond
	})

	goldIcon:addTo(sure)
	goldIcon:setScale(1.2)
	goldIcon:setPosition(90, 70)
end

function WordPeaceChoseBossMediator:handleSelect(node)
	for k, v in pairs(self._allBoss) do
		v:getChildByName("select"):setVisible(false)
	end

	node:getChildByName("select"):setVisible(true)

	self._selectBossId = node.bossId
end

function WordPeaceChoseBossMediator:onCloseClicked()
	self:close()
end

function WordPeaceChoseBossMediator:onClickOK()
	self._worldPeaceSystem:changeChatBoss({
		bossId = self._selectBossId
	}, function()
		self:close()
	end)
end
