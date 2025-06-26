-- chunkname: @IQIGame\\UI\\Battle\\BattleActionSequenceCell.lua

local m = {
	RecoverPosElapsedTime = 0,
	ResistMoveTime = 0,
	UnitId = 0,
	UltimateSkillEffectPlayId = 0,
	IsOccupied = false,
	MOVE_DURATION = 0.5,
	MoveElapsedTime = 0,
	WeakLoopEffectPlayId = 0,
	MoveIndexes = {},
	OnMoveCompleteCallbacks = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.TempUpdatePosition = Vector3.zero
end

function m:OnObtainFromPool(roundDelta, index, points, onMoveStepComplete)
	self.View:SetActive(true)

	self.Points = points
	self.OnMoveStepCompleteCallback = onMoveStepComplete

	self:RefreshPosition(index)
end

function m:RefreshPosition(index)
	self.View.transform.localPosition = self.Points[index].transform.localPosition
	self.PositionAtRoundStart = self.View.transform.anchoredPosition
end

function m:OnRelease()
	self:StopWeakLoopEffect()
	self:StopUltimateSkillEffect()
	self.View:SetActive(false)

	self.Content.transform.localScale = Vector3.one
	self.Icon:GetComponent("Image").color = Color.white

	self:ClearMove()

	self.OnMoveStepCompleteCallback = nil
	self.IsOccupied = false
end

function m:Refresh(unitId, roundDelta)
	self.UnitId = unitId

	local battleUnitPOD = BattleModule.GetBattleUnitPOD(unitId)
	local cfgMonsterData = CfgMonsterTable[battleUnitPOD.MonsterCfgId]

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgMonsterData.HeadIcon), self.Icon:GetComponent("Image"))

	if battleUnitPOD.TroopType == Constant.BattleTroopType.Defend then
		local battleData = BattleModule.GetBattleUnitData(unitId)

		if battleData.WeakNum == 0 then
			self:PlayWeakLoopEffect()
		else
			self:StopWeakLoopEffect()
		end
	end
end

function m:Update(elapseSeconds, realElapseSeconds, isParentMoving)
	if not isParentMoving and self.ResistMoveTime ~= 0 then
		self.RecoverPosElapsedTime = self.RecoverPosElapsedTime + elapseSeconds

		local lerpValue = self.RecoverPosElapsedTime / self.ResistMoveTime

		if lerpValue > 1 then
			lerpValue = 1
		end

		self.View.transform.anchoredPosition = Vector2.Lerp(self.FollowMoveStartPos, self.PositionAtRoundStart, lerpValue)

		if lerpValue == 1 then
			self.RecoverPosElapsedTime = 0
			self.ResistMoveTime = 0
			self.FollowMoveStartPos = nil
		end
	end

	if #self.MoveIndexes >= 2 then
		self.MoveElapsedTime = self.MoveElapsedTime + elapseSeconds

		local fromIndex = self.MoveIndexes[1]
		local toIndex = self.MoveIndexes[2]
		local fromPos = self.Points[fromIndex].transform.localPosition
		local toPos

		if toIndex < 1 then
			local pos1 = self.Points[1].transform.localPosition
			local pos2 = self.Points[2].transform.localPosition

			toPos = Vector3.zero
			toPos.x = pos1.x + (pos2.x - pos1.x) / 2
			toPos.y = pos1.y + (pos1.y - pos2.y) * 2
			toPos.z = pos1.z
		else
			toPos = self.Points[toIndex].transform.localPosition
		end

		local lerpValue = self.MoveElapsedTime / m.MOVE_DURATION

		if lerpValue > 1 then
			lerpValue = 1
		end

		self.View.transform.localPosition = Vector2.Lerp(fromPos, toPos, lerpValue)

		if lerpValue == 1 then
			local fromIndex2 = self.MoveIndexes[1]
			local toIndex2 = self.MoveIndexes[2]
			local moveDelta = toIndex2 - fromIndex2

			table.remove(self.MoveIndexes, 1)

			self.MoveElapsedTime = 0

			self.OnMoveStepCompleteCallback(moveDelta)

			if #self.MoveIndexes <= 1 then
				table.remove(self.MoveIndexes, 1)

				if #self.OnMoveCompleteCallbacks > 0 then
					for i = 1, #self.OnMoveCompleteCallbacks do
						self.OnMoveCompleteCallbacks[i](self.UnitId, toIndex2)
					end

					self.OnMoveCompleteCallbacks = {}
				end
			else
				self:PlayStepAnim(fromIndex2, moveDelta)
			end
		end
	end
end

function m:ResistParentMove(i, cellLength, moveElapsedTime, deltaY, elapseSeconds)
	local level = math.ceil(cellLength / 2)

	if moveElapsedTime < (level - math.ceil(i / 2)) * (0.15 / level) then
		self.TempUpdatePosition.x = self.PositionAtRoundStart.x
		self.TempUpdatePosition.y = self.PositionAtRoundStart.y - deltaY
		self.View.transform.anchoredPosition = self.TempUpdatePosition
		self.ResistMoveTime = self.ResistMoveTime + elapseSeconds
		self.FollowMoveStartPos = self.TempUpdatePosition
	end
end

function m:MoveTo(fromIndex, toIndex, onComplete, notByStep)
	if toIndex == fromIndex then
		return
	end

	local finalDesIndex

	if #self.MoveIndexes > 0 then
		finalDesIndex = self.MoveIndexes[#self.MoveIndexes]
	end

	if toIndex < 1 and finalDesIndex ~= nil and finalDesIndex < 1 then
		return
	end

	if finalDesIndex == toIndex then
		return
	end

	if onComplete ~= nil then
		table.insert(self.OnMoveCompleteCallbacks, onComplete)
	end

	local isMoving

	if #self.MoveIndexes == 0 then
		self.MoveIndexes[1] = fromIndex
		isMoving = false
	else
		isMoving = true
	end

	if notByStep then
		table.insert(self.MoveIndexes, toIndex)
	else
		local moveDelta = toIndex - self.MoveIndexes[#self.MoveIndexes]
		local steps = math.abs(moveDelta)

		for i = 1, steps do
			table.insert(self.MoveIndexes, self.MoveIndexes[#self.MoveIndexes] + moveDelta / steps)
		end

		if not isMoving then
			local initIndex = self.MoveIndexes[1]
			local lToIndex = self.MoveIndexes[2]

			self:PlayStepAnim(initIndex, lToIndex - initIndex)
		end
	end
end

function m:Dead(onPlayDeadAnimComplete)
	local mountPointTrans = getMountPoint(self.View.transform, 50000)

	GameEntry.Effect:PlayUIEffect(9005103, mountPointTrans.position, self.View:GetComponentInParent(typeof(UnityEngine.Canvas)).sortingOrder + 1)

	local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.BattleActionSequenceCell, function()
		self.View:SetActive(false)
	end, 0.2)

	timer:Start()

	local unitId = self.UnitId

	timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.BattleActionSequenceCell, function()
		onPlayDeadAnimComplete(unitId)
	end, 1)

	timer:Start()
end

function m:StartMoveBySpeed(onPlayStartMoveAnimComplete)
	self:PlayAnim("ATBarHead_ScaleLarge2")

	local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.BattleActionSequenceCell, function()
		onPlayStartMoveAnimComplete(self)
	end, 0.3)

	timer:Start()
end

function m:PlayAnim(animationName)
	local animation = self.Content:GetComponent(typeof(UnityEngine.Animation))

	animation:Play(animationName)
end

function m:PlayStepAnim(fromIndex, moveDelta)
	local animationName

	animationName = (fromIndex % 2 == 0 and moveDelta == -1 or fromIndex % 2 == 1 and moveDelta == 1) and "ATBarHead_ScaleLarge1" or "ATBarHead_ScaleSmall1"

	self:PlayAnim(animationName)
end

function m:OnWeakNumChange(fromNum, toNum)
	if toNum == 0 then
		self:OnWeak()
	elseif fromNum == 0 then
		self:OnWeakRecover()
	end
end

function m:OnWeak()
	local mountPointTrans = getMountPoint(self.View.transform, 50000)

	GameEntry.Effect:PlayUIEffect(9005101, mountPointTrans.position, self.View:GetComponentInParent(typeof(UnityEngine.Canvas)).sortingOrder + 1)

	local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.BattleActionSequenceCell, function()
		self:PlayWeakLoopEffect()
	end, 0.15)

	timer:Start()
end

function m:OnWeakRecover()
	self:StopWeakLoopEffect()
end

function m:PlayWeakLoopEffect()
	if self.WeakLoopEffectPlayId == 0 then
		self.WeakLoopEffectPlayId = GameEntry.Effect:PlayUIMountPointEffect(9005102, 50000, 0, self.View, self.View:GetComponentInParent(typeof(UnityEngine.Canvas)).sortingOrder + 1)
	end
end

function m:StopWeakLoopEffect()
	if self.WeakLoopEffectPlayId ~= 0 then
		GameEntry.Effect:StopEffect(self.WeakLoopEffectPlayId)

		self.WeakLoopEffectPlayId = 0
	end
end

function m:CheckUltimateSkillState(isAboutToCastUltimateSkill)
	if isAboutToCastUltimateSkill then
		if self.UltimateSkillEffectPlayId == 0 then
			self.UltimateSkillEffectPlayId = GameEntry.Effect:PlayUIMountPointEffect(9005104, 50000, 0, self.View, self.View:GetComponentInParent(typeof(UnityEngine.Canvas)).sortingOrder + 1)
		end
	else
		self:StopUltimateSkillEffect()
	end
end

function m:StopUltimateSkillEffect()
	if self.UltimateSkillEffectPlayId ~= 0 then
		GameEntry.Effect:StopEffect(self.UltimateSkillEffectPlayId)

		self.UltimateSkillEffectPlayId = 0
	end
end

function m:ClearMove()
	self.MoveIndexes = {}
end

function m:IsMoving()
	return #self.MoveIndexes > 0
end

function m:GetFinalDesIndex()
	if #self.MoveIndexes == 0 then
		return 0
	end

	return self.MoveIndexes[#self.MoveIndexes]
end

function m:Dispose()
	self:StopWeakLoopEffect()
	self:StopUltimateSkillEffect()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.Points = nil
end

return m
