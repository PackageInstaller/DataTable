-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/ScuffleBanPlayer.lua

module("logic.extensions.scuffle.view.ScuffleBanPlayer", package.seeall)

local ScuffleBanPlayer = class("ScuffleBanPlayer")

function ScuffleBanPlayer:ctor(isLeft)
	self._scufflePetCardList = {}
	self._isLeft = isLeft
end

function ScuffleBanPlayer:buildUI(parent, cell)
	self.mainGO = parent
	self._cellGo = cell
	self._myHead = goutil.findChild(self.mainGO, "head")
	self._myTxtRank = goutil.findChildTextComponent(self.mainGO, "txtRank")
	self._myTxtName = goutil.findChildTextComponent(self.mainGO, "txtName")
	self._myTxtAreaName = goutil.findChildTextComponent(self.mainGO, "txtArea")
	self._myLevelIcon = goutil.findChild(self.mainGO, "grade/icon")
	self._myLevelName = goutil.findChildTextComponent(self.mainGO, "grade/txt")
	self._content = goutil.findChild(self.mainGO, "tableview/Viewport/Content")
end

function ScuffleBanPlayer:destroyUI()
	self.mainGO = nil
	self._cellGo = nil
end

function ScuffleBanPlayer:onExit()
	self:_removeCardList()
	self:_removeHead()
end

function ScuffleBanPlayer:setPlayerInfo(isSelf)
	if isSelf then
		self._myTxtRank.text = "排名 " .. ScuffleModel.instance:getMyRank()
		self._myTxtName.text = RoleModel.instance:getUserName()
		self._myTxtAreaName.text = RoleModel.instance:getAreaName()

		HeadItemController.instance:setMyHeadCell(self._myHead)

		local cfg = ScuffleController.instance:getCurLevelCfg()

		if cfg then
			uGuiUtil.setSpriteToImage(self._myLevelIcon, uGuiUtil.SpriteType.BigBg, string.format(ScuffleModel.LevelPath, cfg.icon))

			self._myLevelName.text = cfg.levelName
		end
	else
		local rank = ScuffleModel.instance:getEnemyRank()

		if checknumber(rank) < 0 then
			rank = lang("未上榜")
		end

		self._myTxtRank.text = "排名 " .. rank
		self._myTxtName.text = ScuffleModel.instance:getEnemyName()
		self._myTxtAreaName.text = ScuffleModel.instance:getEnemyAreaName()

		HeadItemController.instance:setHeadCellByInfo(self._myHead, ScuffleModel.instance:getEnemyHeadInfo())

		local cfg = ScuffleConfig.instance:getLevelCfgByScore(ScuffleModel.instance:getEnemyScore())

		if cfg then
			uGuiUtil.setSpriteToImage(self._myLevelIcon, uGuiUtil.SpriteType.BigBg, string.format(ScuffleModel.LevelPath, cfg.icon))

			self._myLevelName.text = cfg.levelName
		end
	end
end

function ScuffleBanPlayer:_removeLevelIcon()
	local levelIcon = Framework.ImageBigBG.Get(self._myLevelIcon)

	levelIcon:ClearImage()
end

function ScuffleBanPlayer:_removeHead()
	MaterialMgr.resetAll(self._myHead)
end

function ScuffleBanPlayer:initCardList(creepsIdList)
	self:_removeCardList()
	self:addCardList(creepsIdList)
end

function ScuffleBanPlayer:addCardList(addList)
	local count = #self._scufflePetCardList
	local internalTime = 0.3

	for index, id in ipairs(addList) do
		local go = goutil.cloneAndSetParent(self._cellGo, self._content.transform, "petCard" .. index)

		go:SetActive(true)

		local scufflePetCard = GameUtil.AddLuaOnce(go, ScufflePetCard)

		scufflePetCard:buildUI(go)
		scufflePetCard:init(index + count, id, internalTime, self._isLeft)

		internalTime = internalTime + 0.3

		table.insert(self._scufflePetCardList, scufflePetCard)
	end
end

function ScuffleBanPlayer:_removeCardList()
	for i, v in ipairs(self._scufflePetCardList) do
		v:onReset()
	end

	table.clear(self._scufflePetCardList)
	goutil.clearChildren(self._content)
end

return ScuffleBanPlayer
