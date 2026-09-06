-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/view/MahjongBattleFmtExView.lua

module("logic.extensions.mahjongbattle.view.MahjongBattleFmtExView", package.seeall)

local MahjongBattleFmtExView = class("MahjongBattleFmtExView", ViewComponent)

function MahjongBattleFmtExView:ctor()
	MahjongBattleFmtExView.super.ctor(self)
end

function MahjongBattleFmtExView:unbindEvents()
	MahjongBattleFmtExView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnHide)
	GameUtil.rmClickHandler(self._btnArrow)
end

function MahjongBattleFmtExView:bindEvents()
	MahjongBattleFmtExView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnHide, self._onClickHide, self)
	GameUtil.addClickHandler(self._btnArrow, self._onClickArrow, self)
end

function MahjongBattleFmtExView:buildUI()
	MahjongBattleFmtExView.super.buildUI(self)

	self._btnHide = self:getGo("btnHide")
	self._btnArrow = self:getGo("moveNode/btnArrow")

	goutil.setActive(self._btnHide, false)
	goutil.setActive(self._btnArrow, false)

	self._moveNode = self:getGo("moveNode")
	self._arrowRectTrans = self:getGo("moveNode/btnArrow/arrowTran")

	local goCell = self:getGo("moveNode/tablecell")
	local goTab = self:getGo("moveNode/tableview")

	self._tableView = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtName = self:getTxt("moveNode/txtName")
	self._txtLv = self:getTxt("moveNode/txtLv")
	self._headIcon = self:getGo("moveNode/headIcon")
	self._myBuff = self:getGo("myBuff")
	self._picBuffMy = self:getGo("myBuff/icon/pic")
	self._txtBuffMy = self:getTxt("myBuff/txt")
	self._opBuff = self:getGo("moveNode/opBuff")
	self._picBuffOp = self:getGo("moveNode/opBuff/icon/pic")
	self._txtBuffOp = self:getTxt("moveNode/opBuff/txt")
	self._titleTeach = self:getGo("moveNode/titleTeach")
end

function MahjongBattleFmtExView:onExit()
	MahjongBattleFmtExView.super.onExit(self)
	self._tableView:dispose()
	HeadItemController.resetHeadCell(self._headIcon)
	uGuiUtil.clearImage(self._picBuffMy)
	uGuiUtil.clearImage(self._picBuffOp)
end

function MahjongBattleFmtExView:onEnter()
	MahjongBattleFmtExView.super.onEnter(self)

	self._isPopupState = true

	local fmtMo = self:getFirstParam()
	local activityId = fmtMo.activityId
	local buffIdMy = 0
	local buffIdOp = 0

	self._petMoList = {}

	local isTeachMode = MahjongBattleController.instance:getIsTeachMode()

	if isTeachMode then
		local teachCfg = MahjongBattleConfig.instance:getTeachCfg(activityId)

		if teachCfg then
			if not teachCfg.teachCreepsMasterId then
				local teachCreepsMasterId = 0
				local masterCfgs = MahjongBattleConfig.instance:getCreepsCfgsById(teachCreepsMasterId) or {}

				for _, masterCfg in ipairs(masterCfgs) do
					local fPowerPet = FightingPowerPetMo.New()

					fPowerPet:fromChallengeCreepCo(masterCfg)

					local petMo = fPowerPet:toBaseBagPetMo()

					if petMo then
						table.insert(self._petMoList, petMo)
					end
				end
			end
		end

		goutil.setActive(self._titleTeach, true)
		goutil.setActive(self._txtName.gameObject, false)
		goutil.setActive(self._txtLv.gameObject, false)
		goutil.setActive(self._headIcon, false)
	else
		goutil.setActive(self._titleTeach, false)
		goutil.setActive(self._txtName.gameObject, true)
		goutil.setActive(self._txtLv.gameObject, true)
		goutil.setActive(self._headIcon, true)

		local baseInfo = MahjongBattleModel.instance:getBaseInfoByActId(activityId)
		local opponent = baseInfo and baseInfo.opponent

		if baseInfo and baseInfo.challengeInfo then
			buffIdMy = baseInfo.challengeInfo.selectSummonBuff or 0
		end

		if opponent then
			buffIdOp = opponent.summonBuff or 0
			self._txtName.text = opponent.headInfo.userName
			self._txtLv.text = string.format("Lv.%d", opponent.headInfo.playerLv)

			local isMirror = checknumber(opponent.headInfo.userId) < 0

			HeadItemController.instance:setHeadCellByInfo(self._headIcon, opponent.headInfo, not isMirror)

			if isMirror then
				local creepsMasterId = Mathf.Abs(checknumber(opponent.headInfo.userId))
				local masterCfgs = MahjongBattleConfig.instance:getCreepsCfgsById(creepsMasterId) or {}

				for _, masterCfg in ipairs(masterCfgs) do
					local fPowerPet = FightingPowerPetMo.New()

					fPowerPet:fromChallengeCreepCo(masterCfg)

					local petMo = fPowerPet:toBaseBagPetMo()

					if petMo then
						table.insert(self._petMoList, petMo)
					end
				end
			elseif not opponent.creepsInfos then
				local creepsInfos = {}

				for _, creepsInfo in ipairs(creepsInfos) do
					local petMo = MahjongBattleModel.instance:getPetMo(activityId, creepsInfo.creepsId, creepsInfo.awakenLevel)

					if petMo then
						table.insert(self._petMoList, petMo)
					end
				end
			end
		end
	end

	self._tableView:reloadData(self._petMoList)

	if buffIdMy > 0 then
		local buffCfg = MahjongBattleConfig.instance:getSummonBuffCfgById(activityId, buffIdMy)

		if buffCfg then
			local spriteName = GameUrl.getIconUrl(buffCfg.buffIcon)

			uGuiUtil.setSpriteToImage(self._picBuffMy, nil, spriteName)

			self._txtBuffMy.text = buffCfg.buffName

			goutil.setActive(self._myBuff, true)
		else
			goutil.setActive(self._myBuff, false)
		end
	else
		goutil.setActive(self._myBuff, false)
	end

	if buffIdOp > 0 then
		local buffCfg = MahjongBattleConfig.instance:getSummonBuffCfgById(activityId, buffIdOp)

		if buffCfg then
			local spriteName = GameUrl.getIconUrl(buffCfg.buffIcon)

			uGuiUtil.setSpriteToImage(self._picBuffOp, nil, spriteName)

			self._txtBuffOp.text = buffCfg.buffName

			goutil.setActive(self._opBuff, true)
		else
			goutil.setActive(self._opBuff, false)
		end
	else
		goutil.setActive(self._opBuff, false)
	end
end

function MahjongBattleFmtExView:_onClickHide()
	if self._isPopupState then
		self._isPopupState = false

		GameUtil.SetActive(self._btnHide, false)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(-110, 80, 0), Vector3.New(400, 80, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 0), Vector3.New(0, 0, 180), 0.2)
	end
end

function MahjongBattleFmtExView:_onClickArrow()
	if self._isPopupState then
		self._isPopupState = false

		GameUtil.SetActive(self._btnHide, false)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(-110, 80, 0), Vector3.New(400, 80, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 0), Vector3.New(0, 0, 180), 0.2)
	else
		self._isPopupState = true

		GameUtil.SetActive(self._btnHide, true)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(400, 80, 0), Vector3.New(-110, 80, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 180), Vector3.New(0, 0, 0), 0.2)
	end
end

function MahjongBattleFmtExView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local petItem = goutil.findChild(go, "petItem")
	local proxy = MaterialMgr.setCellByMo(data, petItem)

	if proxy then
		proxy.binder:setAutoTips(false)
	end
end

function MahjongBattleFmtExView:_clearCell(cell)
	local go = cell.gameObject
	local petItem = goutil.findChild(go, "petItem")

	MaterialMgr.resetAll(petItem)
end

return MahjongBattleFmtExView
