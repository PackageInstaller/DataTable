-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubNewInfoMediator.lua

ClubNewInfoMediator = class("ClubNewInfoMediator", DmPopupViewMediator)

ClubNewInfoMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubNewInfoMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")

local kBtnHandlers = {
	["main.btn_close"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickBack"
	}
}

function ClubNewInfoMediator:initialize()
	super.initialize(self)
end

function ClubNewInfoMediator:dispose()
	super.dispose(self)
end

function ClubNewInfoMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()

	local view = self:getView()
end

function ClubNewInfoMediator:mapEventListeners()
	return
end

function ClubNewInfoMediator:enterWithData(data)
	self._clubInfoOj = data

	self:initNodes()
	self:refreshInfoView()
end

function ClubNewInfoMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("main")

	self._mainPanel:getChildByFullName("title_node.Text_1"):setString(Strings:get("ClubNew_UI_41"))
	self._mainPanel:getChildByFullName("title_node.Text_2"):setString(Strings:get("ClubNew_UI_42"))

	self._applyBtn = self:bindWidget("main.applyBtn", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Confirm",
			func = bind1(self.onClickApply, self)
		}
	})

	local hasJoinClub = self._clubSystem:getHasJoinClub()
	local unlock, tips = self._clubSystem:checkEnabled()

	if hasJoinClub == true or unlock == false then
		self._applyBtn:setVisible(false)
	end
end

function ClubNewInfoMediator:refreshInfoView()
	self:refreshClubIcon()

	local nameLabel = self._mainPanel:getChildByFullName("namelabel")

	nameLabel:setString(self._clubInfoOj.clubName)

	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(236, 255, 143, 255)
		}
	}

	nameLabel:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))

	local idtitlelabel = self._mainPanel:getChildByFullName("idtitlelabel")
	local idLabel = self._mainPanel:getChildByFullName("idlabel")
	local strs = string.split(self._clubInfoOj.clubId, "_")

	idLabel:setString(strs[1])
	idLabel:setPositionX(idtitlelabel:getPositionX() + idtitlelabel:getContentSize().width + 10)

	local Text_6 = self._mainPanel:getChildByFullName("Text_6")
	local proprieterLabel = self._mainPanel:getChildByFullName("proprieterlabel")

	proprieterLabel:setString(self._clubInfoOj.presidentName)
	proprieterLabel:setPositionX(Text_6:getPositionX() + Text_6:getContentSize().width + 10)

	local proprietertitlelabel = self._mainPanel:getChildByFullName("proprietertitlelabel")
	local levelText = self._mainPanel:getChildByFullName("levelText")
	local levelLabel = self._mainPanel:getChildByFullName("levelNum")

	levelLabel:setString(self._clubInfoOj.clubLv)
	levelLabel:setPositionX(levelText:getPositionX() + levelText:getContentSize().width + 10)

	local numtitlelabel = self._mainPanel:getChildByFullName("numtitlelabel")
	local numLabel = self._mainPanel:getChildByFullName("numlabel")

	numLabel:setString(self._clubInfoOj.playerCount)
	numLabel:setPositionX(numtitlelabel:getPositionX() + numtitlelabel:getContentSize().width + numLabel:getContentSize().width + 10)

	local numlabel_Max = self._mainPanel:getChildByFullName("numlabel_Max")

	numlabel_Max:setString("/" .. self._clubInfoOj.playerMax)
	numlabel_Max:setPositionX(numLabel:getPositionX())

	local rankTitleLabel = self._mainPanel:getChildByFullName("rankTitleLabel")
	local rankLabel = self._mainPanel:getChildByFullName("ranklabel")

	rankLabel:setString(Strings:get("Club_Text1", {
		rank = self._clubInfoOj.combatRank
	}))
	rankLabel:setPositionX(rankTitleLabel:getPositionX() + rankTitleLabel:getContentSize().width + 10)

	local manifestoText = self._mainPanel:getChildByFullName("Panel_10.manifestoText")

	manifestoText:setString(self._clubInfoOj.announce)

	local battleRankText = self._mainPanel:getChildByFullName("battleRankText")
	local battlerankNum = self._mainPanel:getChildByFullName("battlerankNum")

	battlerankNum:setString(self._clubInfoOj.bossRank)
	battlerankNum:setPositionX(battleRankText:getPositionX() + battleRankText:getContentSize().width + 10)

	if self._clubInfoOj.bossRank <= 0 then
		battleRankText:setVisible(false)
		battlerankNum:setVisible(false)
	end

	self:doLimitLabelLogic()
end

function ClubNewInfoMediator:doLimitLabelLogic()
	local auditType = self._clubInfoOj.threshold.type
	local limitLevel = self._clubInfoOj.threshold.level
	local limitCombat = self._clubInfoOj.threshold.combat
	local limitText = self._mainPanel:getChildByFullName("limitText")
	local limitNode = self._mainPanel:getChildByFullName("limitLable")

	limitNode:setPositionX(limitText:getPositionX() + limitText:getContentSize().width + 10)
	limitNode:setString("")
	limitNode:removeAllChildren()

	local limitData = {}

	if auditType ~= ClubAuditType.kClose then
		local limitStr = ""

		if limitLevel > 0 then
			limitData[#limitData + 1] = Strings:get("Club_Text110", {
				level = limitLevel
			})
			limitStr = limitData[1] .. "   "
		end

		if limitCombat > 0 then
			limitData[#limitData + 1] = limitCombat

			local combatStr = Strings:get("ARENA_TEAM_SORT_COMBAT") .. " " .. limitCombat

			limitStr = limitStr .. combatStr
		end

		limitNode:setString(limitStr)
	end

	if auditType == ClubAuditType.kLimitCondition then
		if #limitData == 0 then
			limitNode:setString(Strings:get("Club_Text79"))
		end
	elseif auditType == ClubAuditType.kClose then
		limitNode:setString(Strings:get("Club_Text81"))

		limitData = {}
	elseif auditType == ClubAuditType.kFreeOpen and #limitData == 0 then
		limitNode:setString(Strings:get("Club_Text79"))
	end
end

function ClubNewInfoMediator:refreshClubIcon()
	local iconPanel = self._mainPanel:getChildByFullName("iconPanel")

	iconPanel:removeAllChildren()

	local icon = IconFactory:createClubIcon({
		id = self._clubInfoOj.clubImage
	}, {
		isNoBG = true,
		isWidget = true
	})

	icon:addTo(iconPanel):center(iconPanel:getContentSize())
	icon:setScale(2)
end

function ClubNewInfoMediator:onClickBack(sender, eventType)
	self:close()
end

function ClubNewInfoMediator:onClickApply(sender, eventType)
	local auditType = self._clubInfoOj.threshold.type
	local limitLevel = self._clubInfoOj.threshold.level
	local limitCombat = self._clubInfoOj.threshold.combat

	if auditType == ClubAuditType.kClose then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Club_Text195")
		}))

		return
	end

	local factor1 = limitLevel > self._developSystem:getPlayer():getLevel()
	local factor2 = limitCombat > self._developSystem:getTeamByType(StageTeamType.STAGE_NORMAL):getCombat()

	if factor1 and not factor2 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Club_Text196", {
				level = limitLevel,
				combat = limitCombat
			})
		}))

		return
	elseif not factor1 and factor2 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Club_Text197", {
				level = limitLevel,
				combat = limitCombat
			})
		}))

		return
	elseif factor1 and factor2 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Club_Text186", {
				level = limitLevel,
				combat = limitCombat
			})
		}))

		return
	end

	self._clubSystem:requestApplyEnterClub(self._clubInfoOj.clubId, nil, function()
		if not self._clubSystem:getHasJoinClub() then
			if self._clubInfoOj.playerCount >= self._clubInfoOj.playerMax then
				self:dispatch(ShowTipEvent({
					tip = Strings:get("Club_Text187")
				}))
			else
				self:dispatch(ShowTipEvent({
					tip = Strings:get("Club_Text172")
				}))
			end
		end

		self._applyBtn:setVisible(false)
	end)
end
