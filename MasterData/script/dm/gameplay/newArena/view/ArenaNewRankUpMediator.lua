-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/newArena/view/ArenaNewRankUpMediator.lua

ArenaNewRankUpMediator = class("ArenaNewRankUpMediator", DmPopupViewMediator, _M)

ArenaNewRankUpMediator:has("_arenaNewSystem", {
	is = "r"
}):injectWith("ArenaNewSystem")

function ArenaNewRankUpMediator:initialize()
	super.initialize(self)
end

function ArenaNewRankUpMediator:dispose()
	super.dispose(self)
end

function ArenaNewRankUpMediator:onRegister()
	super.onRegister(self)
end

function ArenaNewRankUpMediator:enterWithData(data)
	self._data = data

	self:setViewUI()
end

function ArenaNewRankUpMediator:setViewUI()
	self._main = self:getView():getChildByFullName("main")

	local animNode = self._main:getChildByFullName("animNode")

	self:bindWidget("main.innerUpBtn", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onTouchMaskLayer, self)
		}
	})

	local anim = cc.MovieClip:create("paiming_huodetishi")

	anim:addTo(animNode):posite(0, 60)
	anim:addCallbackAtFrame(39, function()
		anim:stop()
	end)

	local cnText = anim:getChildByFullName("cnText")
	local enText = anim:getChildByFullName("enText")

	AudioEngine:getInstance():playEffect("Se_Alert_Common", false)

	local title = Strings:get("ClassArena_UI33")
	local titleEn = Strings:get("ClassArena_UI75")
	local title1 = cc.Label:createWithTTF(title, CUSTOM_TTF_FONT_1, 50)

	title1:enableOutline(cc.c4b(0, 0, 0, 255), 1)
	title1:addTo(cnText):offset(0, -3)

	local title2 = cc.Label:createWithTTF(titleEn, TTF_FONT_FZYH_M, 18)

	title2:setColor(cc.c3b(150, 160, 255))
	title2:addTo(enText)

	local curRank = self._data.afterRank
	local itemNum = 0

	for k, v in pairs(self._data.rewards or {}) do
		if v.code == CurrencyIdKind.kDiamond then
			itemNum = itemNum + v.amount
		end
	end

	if not self._data.maxChangeRank then
		local maxRankChange = 0
		local rankText = self._main:getChildByFullName("text_rank")
		local rankdesc = self._main:getChildByFullName("text_desc")
		local rankdesc2 = self._main:getChildByFullName("Image_110.text_desc_0")
		local iconNum = self._main:getChildByFullName("text_rank_0")
		local text_rankTitle = self._main:getChildByFullName("text_rankTitle")

		iconNum:setTextColor(GameStyle:getColor(3))
		iconNum:setString(Strings:get("ClassArena_UI36", {
			Num = itemNum
		}))
		rankdesc:setString("")
		rankdesc2:setString("")
		rankText:setString(curRank)
		text_rankTitle:setPositionX(rankText:getPositionX() + rankText:getContentSize().width / 2)

		local f = Strings:get("ClassArena_UI35", {
			fontSize = 20,
			fontName = TTF_FONT_FZYH_M,
			Num = maxRankChange
		})
		local richText = ccui.RichText:createWithXML(f, {})

		richText:setAnchorPoint(rankdesc:getAnchorPoint())
		richText:setPosition(rankdesc:getPosition())
		richText:addTo(rankdesc:getParent())

		local nextReward = self._arenaNewSystem:getNextFirstReward(curRank)

		if next(nextReward) then
			local f = Strings:get("ClassArena_UI37", {
				fontSize = 20,
				fontName = TTF_FONT_FZYH_M,
				Num1 = nextReward.nextRank,
				Num2 = nextReward.rewardNum
			})
			local richText = ccui.RichText:createWithXML(f, {})

			richText:setAnchorPoint(rankdesc2:getAnchorPoint())
			richText:setPosition(rankdesc2:getPosition())
			richText:addTo(rankdesc2:getParent())
		else
			self._main:getChildByFullName("Image_110"):setVisible(false)
		end
	end
end

function ArenaNewRankUpMediator:onTouchMaskLayer()
	self:close()
end
