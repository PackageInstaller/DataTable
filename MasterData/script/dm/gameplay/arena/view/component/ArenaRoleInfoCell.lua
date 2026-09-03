-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/arena/view/component/ArenaRoleInfoCell.lua

ArenaRoleInfoCell = class("ArenaRoleInfoCell", DisposableObject, _M)

ArenaRoleInfoCell:has("_info", {
	is = "r"
})
ArenaRoleInfoCell:has("_mediator", {
	is = "r"
})

local kArenaTimeCoin = CurrencyIdKind.kHonor

function ArenaRoleInfoCell:initialize(info)
	super.initialize(self)

	local resFile = "asset/ui/ArenaRoleInfoCell.csb"

	self._view = cc.CSLoader:createNode(resFile)
	self._mediator = info.mediator

	self:setProperty()
	self:setupView()
end

function ArenaRoleInfoCell:dispose()
	super.dispose(self)
end

function ArenaRoleInfoCell:getView()
	return self._view
end

function ArenaRoleInfoCell:setProperty()
	return
end

function ArenaRoleInfoCell:setupView()
	self:initWidgetInfo()
end

function ArenaRoleInfoCell:initWidgetInfo()
	self._bg = self:getView():getChildByName("bg")
	self._resultPanel = self:getView():getChildByName("resultPanel")

	self._resultPanel:setVisible(false)

	self._name = self._bg:getChildByName("role_name")
	self._level = self._bg:getChildByName("level")
	self._combat = self._bg:getChildByName("combat_number")
	self._roleNode = self._bg:getChildByName("roleNode")
	self._scorePanel = self._bg:getChildByName("scorePanel")

	local text = self._scorePanel:getChildByName("text")
	local coin = IconFactory:createResourcePic({
		id = kArenaTimeCoin
	})

	coin:addTo(text):posite(text:getContentSize().width - 33, text:getContentSize().height / 2)
	coin:setScale(0.6)

	local lineGradiantVec1 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(130, 120, 110, 255)
		}
	}

	self._combat:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))

	local levelBg = cc.Sprite:create("asset/common/common_bg_zdl_s.png")

	levelBg:setAnchorPoint(cc.p(0, 0))
	levelBg:addTo(self._bg):posite(106, 41):setScale(0.8)
	levelBg:setGlobalZOrder(2)
	self._combat:getVirtualRenderer():setGlobalZOrder(3)

	local nameBg = cc.Sprite:createWithSpriteFrameName("jjc_bg_txk_2.png")

	nameBg:addTo(self._bg):posite(114, 28)
	nameBg:setGlobalZOrder(4)
	self._name:getVirtualRenderer():setGlobalZOrder(5)
	self._level:getVirtualRenderer():setGlobalZOrder(6)
end

function ArenaRoleInfoCell:RefreshRoleInfo(data)
	local playerInfo = data

	if playerInfo == nil then
		return
	end

	local combat = playerInfo:getCombat()
	local name = playerInfo:getNickName()
	local level = playerInfo:getLevel()

	self._name:setString(name)
	self._level:setString(Strings:get("CUSTOM_FIGHT_LEVEL") .. level)
	self._combat:setString(combat)
	self._roleNode:removeAllChildren()

	local id = playerInfo:getShowHero()
	local roleModel = IconFactory:getRoleModelByKey("HeroBase", id)
	local info = {
		frameId = "bustframe13_1",
		id = roleModel
	}
	local realImgRole = IconFactory:createRoleIconSpriteNew(info)

	realImgRole:addTo(self._roleNode):center(self._roleNode:getContentSize())
	self._bg:setGray(false)

	local status = playerInfo:getStatus()

	if status ~= ArenaBattleStatus.kNoBattle then
		self._resultPanel:setVisible(true)

		if status == ArenaBattleStatus.kWinBattle then
			self._resultPanel:getChildByName("text"):setString(Strings:get("Arena_Victory"))
			self._bg:setColor(cc.c3b(125, 125, 125))
			self:setStyle(true)
			self._resultPanel:getChildByName("image"):loadTexture("common_bg_shengli.png", ccui.TextureResType.localType)
		elseif status == ArenaBattleStatus.kLoseBattle then
			self._resultPanel:getChildByName("image"):loadTexture("bg_shibai.png", ccui.TextureResType.plistType)
			self._resultPanel:getChildByName("text"):setString(Strings:get("Arena_Defeat"))
			self:setStyle()
		end
	else
		self._resultPanel:setVisible(false)
	end

	local score = playerInfo:getExtra()
	local text = self._scorePanel:getChildByName("text")

	text:setString("+" .. score)
	self._scorePanel:setVisible(score ~= 0)
	self._bg:getChildByName("bg"):loadTexture(self._mediator:getArenaSystem():getExtraCoinBg(score), 1)
end

function ArenaRoleInfoCell:setStyle(win)
	local outlineColor = cc.c4b(0, 0, 0, 255)
	local outlineWidth = 1
	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(204, 204, 204, 255)
		}
	}
	local lineGradiantDir = {
		x = 0,
		y = -1
	}

	self._resultPanel:getChildByName("text"):enableOutline(outlineColor, outlineWidth)
	self._resultPanel:getChildByName("text"):enablePattern(cc.LinearGradientPattern:create((win or nil) and {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(250, 250, 207, 255)
		}
	}, lineGradiantDir))
end
