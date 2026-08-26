-- chunkname: @modules/logic/fight/view/FightSeasonSubHeroItem.lua

module("modules.logic.fight.view.FightSeasonSubHeroItem", package.seeall)

local FightSeasonSubHeroItem = class("FightSeasonSubHeroItem", FightBaseView)

function FightSeasonSubHeroItem:onInitView()
	self._headIcon = gohelper.findChildSingleImage(self.viewGO, "#simage_Head")
	self._hpSlider = gohelper.findChildImage(self.viewGO, "infoPart/HP/#image_HPFG")
	self._pointRoot = gohelper.findChild(self.viewGO, "infoPart/Point")
	self._pointItem = gohelper.findChild(self.viewGO, "infoPart/Point/pointItem")
	self._btn = gohelper.findChildClickWithDefaultAudio(self.viewGO, "btn")
	self._aniPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._ani = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))
	self._fillImage = gohelper.findChildImage(self.viewGO, "#image_ItemBGFilled")

	local mat = UnityEngine.Object.Instantiate(self._fillImage.material)

	self._fillImage.material = mat
	self._fillMat = mat
	self._hpRoot = gohelper.findChild(self.viewGO, "infoPart")
	self._effectHeal = gohelper.findChild(self.viewGO, "infoPart/eff_heal")
	self._infoPart = gohelper.findChild(self.viewGO, "infoPart")
	self._point2Root = gohelper.findChild(self.viewGO, "infoPart/Point2")
	self._point2Item = gohelper.findChild(self.viewGO, "infoPart/Point2/pointItem")
end

function FightSeasonSubHeroItem:addEvents()
	self:com_registClick(self._btn, self._onBtnClick)
	self:com_registFightEvent(FightEvent.OnExPointChange, self._onExPointChange)
	self:com_registFightEvent(FightEvent.UpdateExPoint, self._onUpdateExPoint)
	self:com_registFightEvent(FightEvent.ReplaceEntityMO, self._onReplaceEntityMO)
	self:com_registFightEvent(FightEvent.BeforeChangeSubHero, self._onBeforeChangeSubHero)
	self:com_registFightEvent(FightEvent.ChangeSubEntityHp, self._onChangeSubEntityHp)
	self:com_registFightEvent(FightEvent.EntitySync, self._onEntitySync)
	self:com_registFightEvent(FightEvent.ChangeEntitySubCd, self._onChangeEntitySubCd)
	self:com_registFightEvent(FightEvent.StageChanged, self._onStageChanged)
end

function FightSeasonSubHeroItem:removeEvents()
	return
end

function FightSeasonSubHeroItem:_onExPointChange(entityId, old_num, new_num)
	if entityId == self._entityId then
		self:com_registSingleTimer(self._delayHideInfo, 0.6)
		self:_refreshExpoint(true, old_num, new_num)

		if self:_canUse() then
			self:playAni("max_in", true)
			AudioMgr.instance:trigger(410000105)
		else
			self:refreshAni()
		end

		if new_num == 5 then
			FightController.instance:dispatchEvent(FightEvent.GuideSubEntityExpoint5)
		end
	end
end

function FightSeasonSubHeroItem:_delayHideInfo()
	local can = self:_canUse()

	gohelper.setActive(self._effectHeal, false)
end

function FightSeasonSubHeroItem:_onUpdateExPoint(entityId, old_num, new_num)
	self:_onExPointChange(entityId, old_num, new_num)
end

function FightSeasonSubHeroItem:_onReplaceEntityMO(entityMO)
	if entityMO.id == self._entityId then
		self:refreshData(self._entityId)
	end
end

function FightSeasonSubHeroItem:_onBeforeChangeSubHero(exitEntityId, changedId)
	if changedId == self._entityId then
		local exitEntityData = FightDataHelper.entityMgr:getById(exitEntityId)

		if exitEntityData and exitEntityData:isStatusDead() then
			self.PARENT_VIEW:onOpen()

			return
		end

		self:refreshData(exitEntityId)
	end
end

function FightSeasonSubHeroItem:_onChangeSubEntityHp(entityId, offset)
	if entityId == self._entityId then
		self:_refreshHp(true)

		if offset > 0 then
			self:com_registSingleTimer(self._delayHideInfo, 0.6)
			gohelper.setActive(self._effectHeal, true)
		end
	end
end

function FightSeasonSubHeroItem:onOpen()
	gohelper.setActive(self._effectHeal, false)
end

function FightSeasonSubHeroItem:_canUse()
	local entityMO = FightDataHelper.entityMgr:getById(self._entityId)
	local expoint = entityMO:getExPoint()

	if expoint >= entityMO:getUniqueSkillPoint() then
		return true
	end
end

function FightSeasonSubHeroItem:_onBtnClick()
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	if not self:_canUse() then
		return
	end

	local entityMO = FightDataHelper.entityMgr:getById(self._entityId)

	if entityMO.subCd ~= 0 then
		GameFacade.showToast(ToastEnum.CanNotUseSeasonChangeHeroCd)

		return
	end

	if not FightDataHelper.stageMgr:isEmptyOperateState() then
		local curState = FightDataHelper.stageMgr:getCurOperateState()

		if curState == FightStageMgr.OperateStateType.SeasonChangeHero then
			if self.PARENT_VIEW:selecting(self) then
				return
			end

			self:selectItem()
		end

		return
	end

	self.PARENT_VIEW:_enterOperate()
	self:selectItem()
end

function FightSeasonSubHeroItem:selectItem()
	AudioMgr.instance:trigger(410000106)
	self.PARENT_VIEW:selectItem(self)
end

function FightSeasonSubHeroItem:_onChangeEntitySubCd(entityId)
	if entityId == self._entityId then
		self:refreshAni()
	end
end

function FightSeasonSubHeroItem:_onEntitySync(entityId)
	if entityId == self._entityId then
		local entityMO = FightDataHelper.entityMgr:getById(self._entityId)

		if entityMO.subCd ~= 0 then
			self:playAni("cd_in", true)
		end
	end
end

function FightSeasonSubHeroItem:_onStageChanged(stage)
	self:refreshAni()
end

function FightSeasonSubHeroItem:refreshAni()
	if not self.viewGO.activeInHierarchy then
		return
	end

	local entityMO = FightDataHelper.entityMgr:getById(self._entityId)

	if entityMO.subCd ~= 0 then
		self:playAni("cd_idle", nil, true)
	elseif self:_canUse() then
		self:playAni("max_idle", nil, true)
	else
		self:playAni("normal_idle", nil, true)
	end
end

function FightSeasonSubHeroItem:playAni(name, needRefresh, loop)
	if not self.viewGO.activeInHierarchy then
		return
	end

	if name == "select_in" then
		self._aniPlayer:Play(name, nil, nil)
	elseif needRefresh then
		self._aniPlayer:Play(name, self.refreshAni, self)
	elseif loop then
		self._ani.enabled = true

		self._ani:Play(name)
	else
		self._aniPlayer:Play(name, nil, nil)
	end
end

function FightSeasonSubHeroItem:refreshData(data)
	self._entityId = data

	local entityMO = FightDataHelper.entityMgr:getById(self._entityId)
	local skinConfig = SkinConfig.instance:getSkinCo(entityMO.skin)

	self._headIcon:LoadImage(ResUrl.roomHeadIcon(skinConfig.headIcon))
	self:_refreshExpoint()
	self:_refreshHp()
	self:refreshAni()

	local can = self:_canUse()
end

function FightSeasonSubHeroItem:_buildDataListByNum(num)
	local dataList = {}

	for i = 1, num do
		table.insert(dataList, i)
	end

	return dataList
end

function FightSeasonSubHeroItem:_refreshExpoint(bgTween, oldNum, newNum)
	local entityMO = FightDataHelper.entityMgr:getById(self._entityId)

	self._expointObj = {}
	self._expointMax = entityMO:getMaxExPoint()
	self._curExpoint = entityMO:getExPoint()

	gohelper.setActive(self._point2Root, false)

	if self._expointMax <= 6 then
		gohelper.CreateObjList(self, self._onPointItemShow, self:_buildDataListByNum(math.min(self._expointMax, 6)), self._pointRoot, self._pointItem)
	elseif self._expointMax <= 12 then
		gohelper.setActive(self._point2Root, true)
		gohelper.CreateObjList(self, self._onPointItemShow, self:_buildDataListByNum(6), self._pointRoot, self._pointItem)
		gohelper.CreateObjList(self, self._onPoint2ItemShow, self:_buildDataListByNum(self._expointMax - 6), self._point2Root, self._point2Item)
	else
		gohelper.CreateObjList(self, self._onPointItemShow, self:_buildDataListByNum(self._expointMax), self._pointRoot, self._pointItem)
	end

	for i, v in ipairs(self._expointObj) do
		gohelper.setActive(v.light, i <= self._curExpoint)
	end

	local uniqueCost = entityMO:getUniqueSkillPoint()

	if bgTween and oldNum and newNum then
		self:_releaseTween()

		self._tweenId = ZProj.TweenHelper.DOTweenFloat(oldNum / uniqueCost, newNum / uniqueCost, 0.3 / FightModel.instance:getUISpeed(), self._expointTweenCallback, nil, self)

		if oldNum < newNum then
			for i = oldNum + 1, newNum do
				if self._expointObj[i] and self.viewGO.activeInHierarchy then
					self._expointObj[i].ani:Play("in", nil, nil)
				end
			end
		end
	else
		self._fillMat:SetFloat("_LerpOffset", self._curExpoint / uniqueCost)
	end
end

function FightSeasonSubHeroItem:_expointTweenCallback(value)
	self._fillMat:SetFloat("_LerpOffset", value)
end

function FightSeasonSubHeroItem:_releaseTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function FightSeasonSubHeroItem:_onPointItemShow(obj, data, index)
	if not self._expointObj[index] then
		self._expointObj[index] = self:newUserDataTable()
		self._expointObj[index].light = gohelper.findChild(obj, "#go_FG")
		self._expointObj[index].mask = gohelper.findChild(obj, "#go_Mask")
		self._expointObj[index].ani = SLFramework.AnimatorPlayer.Get(obj)
	end
end

function FightSeasonSubHeroItem:_onPoint2ItemShow(obj, data, index)
	index = index + 6

	if not self._expointObj[index] then
		self._expointObj[index] = self:newUserDataTable()
		self._expointObj[index].light = gohelper.findChild(obj, "#go_FG")
		self._expointObj[index].mask = gohelper.findChild(obj, "#go_Mask")
		self._expointObj[index].ani = SLFramework.AnimatorPlayer.Get(obj)
	end
end

function FightSeasonSubHeroItem:_refreshHp(tween)
	local entityMO = FightDataHelper.entityMgr:getById(self._entityId)
	local max = entityMO.attrMO.hp
	local currentHp = entityMO.currentHp

	if tween then
		self:_releaseHpTween()

		self._hpTween = ZProj.TweenHelper.DOFillAmount(self._hpSlider, currentHp / max, 0.3)
	else
		self._hpSlider.fillAmount = currentHp / max
	end
end

function FightSeasonSubHeroItem:_releaseHpTween()
	if self._hpTween then
		ZProj.TweenHelper.KillById(self._hpTween)

		self._hpTween = nil
	end
end

function FightSeasonSubHeroItem:onClose()
	self:_releaseTween()
	self:_releaseHpTween()
end

function FightSeasonSubHeroItem:onDestroyView()
	return
end

return FightSeasonSubHeroItem
