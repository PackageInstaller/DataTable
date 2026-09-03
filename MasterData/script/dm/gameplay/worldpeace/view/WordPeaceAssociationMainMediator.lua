-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WordPeaceAssociationMainMediator.lua

WordPeaceAssociationMainMediator = class("WordPeaceAssociationMainMediator", ClubNewHallMediator, _M)

WordPeaceAssociationMainMediator:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")

function WordPeaceAssociationMainMediator:setUpData()
	self._clubInfoOj = self._worldPeaceSystem:getClubInfoOj()
	self._memberRecordListOj = self._worldPeaceSystem:getMemberRecordListOj()
	self._officerLevels = {
		{},
		{},
		{}
	}

	self:sortMemerList()
end

function WordPeaceAssociationMainMediator:handleHost()
	self._auditBtn:setVisible(false)
	self._dailyBtn:setVisible(false)
	self._welcomeBtn:setVisible(false)
	self._quitMemberBtn:setVisible(false)
end

function WordPeaceAssociationMainMediator:updateCell(cell, index, data)
	super.updateCell(self, cell, index, data)
	cell:getChildByFullName("content.btn_xq"):setVisible(false)
end

function WordPeaceAssociationMainMediator:refreshMangerPanel()
	return
end

function WordPeaceAssociationMainMediator:sortMemerList()
	self._memberList = self._memberRecordListOj:getList()
	self._allClubMembers = {}

	for k, v in pairs(self._officerLevels) do
		self._allClubMembers[k] = {}
	end

	for k, v in pairs(self._memberList) do
		self._allClubMembers[1][#self._allClubMembers[1] + 1] = v
	end
end

function WordPeaceAssociationMainMediator:getClubInfoObj()
	return self._worldPeaceSystem:getClubInfoOj()
end

function WordPeaceAssociationMainMediator:enterWithData(data)
	if data.playerList then
		self._worldPeaceSystem:getMemberRecordListOj():cleanUp()
		self._worldPeaceSystem:getMemberRecordListOj():synchronize({
			lb = data.playerList
		})
	end

	if data.myPosition then
		self._worldPeaceSystem:getClubInfoOj():setPosition(data.myPosition)
	end

	if data.playerMax then
		self._worldPeaceSystem:getClubInfoOj():setMemberLimitCount(data.playerMax)
	end

	if data.clubRank then
		self._worldPeaceSystem:getClubInfoOj():setRank(data.clubRank)
	end

	if data.presidentName then
		self._worldPeaceSystem:getClubInfoOj():setProprieterName(data.presidentName)
	end

	if data.normalCount then
		self._worldPeaceSystem:getClubInfoOj():setMemberCount(data.normalCount)
	end

	if data.personClubGift then
		self._worldPeaceSystem:getClubInfoOj():setPersonClubGift(data.personClubGift)
	end

	if data.playerCount then
		self._worldPeaceSystem:getClubInfoOj():setPlayerCount(data.playerCount)
	end

	if data.viceCount then
		self._worldPeaceSystem:getClubInfoOj():setDProprieterCount(data.viceCount)
	end

	if data.eliteCount then
		self._worldPeaceSystem:getClubInfoOj():setEliteCount(data.eliteCount)
	end

	if data.clubInfo then
		self._worldPeaceSystem:getClubInfoOj():sync(data.clubInfo)
		self._worldPeaceSystem:getClubInfoOj():setClubId(data.clubInfo.id)
	else
		self._worldPeaceSystem:getClubInfoOj():setClubId("")
	end

	self:initNodes()
	self:setupTopInfoWidget()
	self:setUpData()
	self:refreshSelfView()
	self:requestAuditData()
	self:handleHost()
end

function WordPeaceAssociationMainMediator:refreshSelfView()
	self:refreshInfoView()
	self:createTableView()
end
