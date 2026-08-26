-- chunkname: @modules/logic/autochess/main/view/comp/AutoChessLeaderEntity.lua

module("modules.logic.autochess.main.view.comp.AutoChessLeaderEntity", package.seeall)

local AutoChessLeaderEntity = class("AutoChessLeaderEntity", LuaCompBase)

function AutoChessLeaderEntity:init(go)
	self.go = go
	self.transform = go.transform
	self.goEntity = gohelper.findChild(go, "ani/Entity")
	self.dirTrs = self.goEntity.transform
	self.goMesh = gohelper.findChild(go, "ani/Entity/Mesh")

	local barGo = gohelper.findChild(go, "ani/Bar")

	self.goHp = gohelper.findChild(barGo, "Hp")
	self.txtHp = gohelper.findChildText(barGo, "Hp/txt_Hp")
	self.anim = gohelper.findChild(go, "ani"):GetComponent(gohelper.Type_Animator)

	local go1 = gohelper.findChild(barGo, "HpChange")

	self.hpChangeAnim = go1:GetComponent(gohelper.Type_Animator)
	self.txtHpAdd = gohelper.findChildText(barGo, "HpChange/txt_HpAdd")
	self.txtHpSub = gohelper.findChildText(barGo, "HpChange/txt_HpSub")
	self.meshComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.goMesh, AutoChessMeshComp)
	self.effectComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.goEntity, AutoChessEffectComp)
	self.goPlayerBuff = gohelper.findChild(go, "ani/go_PlayerBuff")
	self.txtEnergyL = gohelper.findChildText(go, "ani/go_PlayerBuff/txt_EnergyL")
	self.txtFireL = gohelper.findChildText(go, "ani/go_PlayerBuff/txt_FireL")
	self.txtDebrisL = gohelper.findChildText(go, "ani/go_PlayerBuff/txt_DebrisL")
	self.goEnemyBuff = gohelper.findChild(go, "ani/go_EnemyBuff")
	self.txtEnergyR = gohelper.findChildText(go, "ani/go_EnemyBuff/txt_EnergyR")
	self.txtFireR = gohelper.findChildText(go, "ani/go_EnemyBuff/txt_FireR")
	self.txtDebrisR = gohelper.findChildText(go, "ani/go_EnemyBuff/txt_DebrisR")
	self.goCollection = gohelper.findChild(go, "ani/go_Collection")
	self.btnCollection = gohelper.findChildButtonWithAudio(go, "ani/go_Collection")
	self.goCollectionItem = gohelper.findChild(go, "ani/go_Collection/Viewport/Content/go_CollectionItem")

	self.addClickCb(self, self.btnCollection, self._btnCollectionOnClick, self)

	self.collectionTbl = {}
end

function AutoChessLeaderEntity:_btnCollectionOnClick()
	local collectionIds = self.data.collectionIds

	ViewMgr.instance:openView(ViewName.AutoChessCollectionView, collectionIds)
end

function AutoChessLeaderEntity:setData(data)
	self.data = data
	self.data.hp = tonumber(data.hp)
	self.config = AutoChessConfig.instance:getLeaderCfg(self.data.id)

	local dir = self.data.teamType == AutoChessEnum.TeamType.Enemy and 1 or -1

	transformhelper.setLocalScale(self.dirTrs, dir, 1, 1)

	self.isEnemey = self.data.teamType == AutoChessEnum.TeamType.Enemy

	if self.isEnemey then
		recthelper.setAnchorX(self.goHp.transform, 130)
		recthelper.setAnchorX(self.goCollection.transform, -480)
	end

	self.meshComp:setData(self.config.image, self.isEnemey, true)
	self:updateHp(0)
	self:show()
end

function AutoChessLeaderEntity:attack()
	self.anim:Play("attack", 0, 0)

	return 0.44
end

function AutoChessLeaderEntity:skillAnim(animName)
	self.anim:Play(animName, 0, 0)

	return 0.44
end

function AutoChessLeaderEntity:ranged(targetPos, effectId)
	self.anim:Play("attack", 0, 0)

	local param = {
		flyPos = targetPos
	}

	return (self:playEffect(effectId, param))
end

function AutoChessLeaderEntity:updateHp(value)
	value = tonumber(value)
	self.data.hp = self.data.hp + value
	self.txtHp.text = self.data.hp
end

function AutoChessLeaderEntity:floatHp(value)
	value = tonumber(value)

	if value > 0 then
		self.txtHpAdd.text = "+" .. value

		self.hpChangeAnim:Play("hpadd", 0, 0)
	else
		self.txtHpSub.text = value

		self.hpChangeAnim:Play("hpsub", 0, 0)
		self:playEffect(20001)
	end
end

function AutoChessLeaderEntity:addBuff(buff)
	table.insert(self.data.buffContainer.buffs, buff)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateLeaderBuff)
	self:refreshBuff()
end

function AutoChessLeaderEntity:updateBuff(buff)
	local buffs = self.data.buffContainer.buffs

	for k, buff1 in ipairs(buffs) do
		if buff1.uid == buff.uid then
			buffs[k] = buff

			break
		end
	end

	AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateLeaderBuff)
	self:refreshBuff()
end

function AutoChessLeaderEntity:delBuff(buffUid)
	local buffs = self.data.buffContainer.buffs
	local index

	for k, buff in ipairs(buffs) do
		if buff.uid == buffUid then
			index = k

			break
		end
	end

	if index then
		table.remove(buffs, index)
	else
		logError(string.format("异常:移除了不存在的棋子UID%s", buffUid))
	end

	AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateLeaderBuff)
	self:refreshBuff()
end

function AutoChessLeaderEntity:hide()
	gohelper.setActive(self.go, false)
end

function AutoChessLeaderEntity:show()
	self.pos = AutoChessGameModel.instance:getLeaderLocation(self.data.teamType)

	if self.pos then
		recthelper.setAnchor(self.transform, self.pos.x, self.pos.y)
		gohelper.setActive(self.go, true)
	end
end

function AutoChessLeaderEntity:showBattle()
	self.isShowBattle = true

	self:refreshBuff()
	self:refreshCollection()
end

function AutoChessLeaderEntity:refreshBuff()
	if not self.isShowBattle then
		return
	end

	local buffs = self.data.buffContainer.buffs
	local energy = AutoChessHelper.getBuffCnt(buffs, AutoChessEnum.EnergyBuffIds)
	local fire = AutoChessHelper.getBuffCnt(buffs, AutoChessEnum.FireBuffIds)
	local debris = AutoChessHelper.getBuffCnt(buffs, AutoChessEnum.DebrisIds)

	if self.isEnemey then
		self.txtEnergyR.text = energy

		gohelper.setActive(self.txtEnergyR, energy ~= 0)

		self.txtFireR.text = fire

		gohelper.setActive(self.txtFireR, fire ~= 0)

		self.txtDebrisR.text = debris

		gohelper.setActive(self.txtDebrisR, debris ~= 0)
	else
		self.txtEnergyL.text = energy

		gohelper.setActive(self.txtEnergyL, energy ~= 0)

		self.txtFireL.text = fire

		gohelper.setActive(self.txtFireL, fire ~= 0)

		self.txtDebrisL.text = debris

		gohelper.setActive(self.txtDebrisL, debris ~= 0)
	end

	gohelper.setActive(self.goPlayerBuff, not self.isEnemey)
	gohelper.setActive(self.goEnemyBuff, self.isEnemey)
end

function AutoChessLeaderEntity:playEffect(effectId, param)
	if param and param.flyPos then
		gohelper.setAsLastSibling(self.go)
	end

	local effectCo = lua_auto_chess_effect.configDict[effectId]

	self.effectComp:playEffect(effectCo, param)

	return effectCo.duration
end

function AutoChessLeaderEntity:refreshCollection()
	if not self.isShowBattle then
		return
	end

	local collectionIds = self.data.collectionIds
	local count = #collectionIds

	if count ~= 0 then
		for k, id in ipairs(collectionIds) do
			local item = self.collectionTbl[k]

			if not item then
				item = self:getUserDataTb_()
				item.go = gohelper.cloneInPlace(self.goCollectionItem)
				item.simageIcon = gohelper.findChildSingleImage(item.go, "simage_icon")
				self.collectionTbl[k] = item
			end

			local config = AutoChessConfig.instance:getCollectionCfg(id)

			item.simageIcon:LoadImage(ResUrl.getAutoChessIcon(config.image, "collection"))
			gohelper.setActive(item.go, true)
		end

		for i = count + 1, #self.collectionTbl do
			gohelper.setActive(self.collectionTbl[i].go, false)
		end
	end

	gohelper.setActive(self.goCollection, count ~= 0)
end

return AutoChessLeaderEntity
