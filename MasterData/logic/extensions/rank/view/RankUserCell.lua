-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/view/RankUserCell.lua

module("logic.extensions.rank.view.RankUserCell", package.seeall)

local M = class("RankUserCell")

function M:ctor(compContainer)
	self._viewElementsRegistry = ViewElementsRegistry.New(compContainer.gameObject)
	self._data = nil
end

function M:Awake()
	self.go_first = self:findUIElement("player_ranking_common_item_1146449533")
	self.go_second = self:findUIElement("player_ranking_common_item_-373613288")
	self.go_third = self:findUIElement("player_ranking_common_item_486742226")
	self.go_other = self:findUIElement("player_ranking_common_item_260352726")
	self.img_other_di = self:findUIElement("player_ranking_common_item_260352726", UIComponentType.Image)
	self.text_txtName = self:findUIElement("player_ranking_common_item_173345726", UIComponentType.Text)
	self.text_txtRankNum = self:findUIElement("player_ranking_common_item_1845204579", UIComponentType.Text)
	self.img_userIcon = self:findUIElement("player_ranking_common_item_1720523792", UIComponentType.Image)
	self.img_imgCard = self:findUIElement("player_ranking_common_item_911648756", UIComponentType.Image)
	self.btn_btnUser = self:findUIElement("player_ranking_common_item_-1461125854", UIComponentType.ButtonAdapter)
	self.text_txtNotListed = self:findUIElement("player_ranking_common_item_-1452101542", UIComponentType.Text)

	self.btn_btnUser:AddClickListener(self._onClickUser, self)
end

function M:updateData(data)
	self._data = data

	if not data then
		return
	end

	local rank = data:getRank()

	goutil.setActive(self.go_first, rank == 1)
	goutil.setActive(self.go_second, rank == 2)
	goutil.setActive(self.go_third, rank == 3)
	goutil.setActive(self.go_other, rank > 3)
	goutil.setActive(self.text_txtNotListed.gameObject, rank <= 0)

	self.text_txtName.text = data:getNickname()
	self.text_txtRankNum.text = rank
	self.text_txtNotListed.text = lang("rank_no_ranking")

	local portraitCO = BackpackConfig.instance:getItemInfoByItemId(data:getPortrait())

	if portraitCO then
		IconLoader.setSprite(self.img_userIcon, IconType.PlayerInfoMask, portraitCO.icon)
	end

	local cardBg = data:getdisplayCardBgIcon()

	if cardBg then
		IconLoader.setSprite(self.img_imgCard, IconType.PlayerInfoCard, cardBg)
	end

	self.img_other_di.enabled = self._data:getUserId() ~= PlayerModel.instance:getId()
end

function M:_onClickUser()
	if not self._data then
		return
	end

	if self._data:getUserId() == PlayerModel.instance:getId() then
		FloatWordMgr.instance:show(lang("tip_is_oneself"))

		return
	end

	local bindGo = self.btn_btnUser.gameObject
	local uid = self._data:getUserId()
	local playerLv = self._data:getPlayerLv()
	local portrait = self._data:getPortrait()
	local nickName = self._data:getNickname()

	ToolTipsMgr.showPlayerInfoTips(bindGo, uid, playerLv, portrait, nickName)
end

function M:findUIElement(key, mtype)
	return self._viewElementsRegistry:findUIElement(key, mtype)
end

function M:OnDestroy()
	self.btn_btnUser:RemoveClickListener()
	self._viewElementsRegistry:cleanRegistry()

	self._viewElementsRegistry = nil
	self._data = nil
end

return M
