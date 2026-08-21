-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleTalentCell.lua

local strClassName = "CircleTalentCell"
local CircleTalentCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function CircleTalentCell:ctor()
	self:initUI()
end

function CircleTalentCell:initUI()
	self.sliderProficiency = UIControls.Slider(self, "Slider")
	self.imgFill = UIControls.Image(self, "Slider/Fill")
	self.imgBgTalent = UIControls.Image(self, "BgTalent")
	self.imgIcon = UIControls.Image(self, "BgTalent/IconTalent")
	self.panelCondition = UIControls.Panel(self, "BgTalent/ConditionPanel")
	self.txtConditionNum = UIControls.Label(self, "BgTalent/ConditionPanel/TextNum")
	self.txtAttrOdd = UIControls.Label(self, "BgTalent/TextAttrOdd")
	self.txtAttrEven = UIControls.Label(self, "BgTalent/TextAttrEven")
	self.imgIconNew = UIControls.Image(self, "IconNew")
end

function CircleTalentCell:setCircleTalentData(talentData, idx)
	self.aniUnlock = UIControls.UIAni(self, "BgTalent/ConditionPanel")
	self.talentData = talentData
	self.delayPlayAni = nil
	self.idx = idx

	local curProficiency = self.talentData.curProficiency

	if curProficiency >= self.talentData.resData.proficiency then
		self.sliderProficiency:setValue(1)
	else
		local lastProficiency = self.talentData.lastProficiency
		local progress = (curProficiency - lastProficiency) / (self.talentData.resData.proficiency - lastProficiency)

		self.sliderProficiency:setValue(progress)
	end

	if CurAvatar.myCircle then
		if self.talentData.type == Const.CIRCLE_TALENT_TYPE_SEARCH then
			self.imgFill:setImage("Atlas/CircleBattleAtlas/CircleBattleAtlas3", "BgTalentBarSearch")
			self.imgBgTalent:setImage("Atlas/CircleBattleAtlas/CircleBattleAtlas3", "BgTalentSearch")

			if CurAvatar.hintExploreTalentDic[self.talentData.resData.id] then
				CurAvatar.hintExploreTalentDic[self.talentData.resData.id] = nil

				self.panelCondition:setVisible(true)

				if self.mWindow.mOpening then
					self.delayPlayAni = "UnlockTalent"
				else
					self.coPlayAni = coroutine.start(self.coPlayAniFunc, self, "UnlockTalent")
				end
			elseif self.talentData.isActive then
				self.panelCondition:setVisible(false)
			else
				self.panelCondition:setVisible(true)

				self.coPlayAni = coroutine.start(self.coPlayAniFunc, self, "UnlockTalentReset")
			end
		elseif self.talentData.type == Const.CIRCLE_TALENT_TYPE_BATTLE then
			self.imgFill:setImage("Atlas/CircleBattleAtlas/CircleBattleAtlas3", "BgTalentBarBattle")
			self.imgBgTalent:setImage("Atlas/CircleBattleAtlas/CircleBattleAtlas3", "BgTalentBattle")

			if CurAvatar.hintBattleTalentDic[self.talentData.resData.id] then
				CurAvatar.hintBattleTalentDic[self.talentData.resData.id] = nil

				self.panelCondition:setVisible(true)

				if self.mWindow.mOpening then
					self.delayPlayAni = "UnlockTalent"
				else
					self.coPlayAni = coroutine.start(self.coPlayAniFunc, self, "UnlockTalent")
				end
			elseif self.talentData.isActive then
				self.panelCondition:setVisible(false)
			else
				self.panelCondition:setVisible(true)

				self.coPlayAni = coroutine.start(self.coPlayAniFunc, self, "UnlockTalentReset")
			end
		end

		self.imgIcon:setImage(self.talentData.resData.icon_path, self.talentData.resData.icon)
		self.txtConditionNum:setText(curProficiency .. "/" .. self.talentData.resData.proficiency)
		self:setCellGray(not self.talentData.isActive)

		if self.idx % 2 == 0 then
			self.txtAttrEven:setVisible(true)
			self.txtAttrOdd:setVisible(false)
			self.txtAttrEven:setText(self.talentData.resData.desc)
		else
			self.txtAttrEven:setVisible(false)
			self.txtAttrOdd:setVisible(true)
			self.txtAttrOdd:setText(self.talentData.resData.desc)
		end
	end
end

function CircleTalentCell:coPlayAniFunc(aniName)
	coroutine.step()
	self.aniUnlock:startAni(aniName, true)
end

function CircleTalentCell:onClear()
	CircleTalentCell.super.onClear(self)
	self:clearCoroutine()
end

function CircleTalentCell:clearCoroutine()
	if self.coPlayAniFunc then
		coroutine.stop(self.coPlayAniFunc)

		self.coPlayAniFunc = nil
	end
end

function CircleTalentCell:playUnlock()
	if self.delayPlayAni then
		self.aniUnlock:startAni(self.delayPlayAni, true)
	end
end

function CircleTalentCell:setCellGray(isGray)
	if self.imgIcon and self.imgIcon:getVisible() then
		self.imgIcon:setImageGray(isGray)
	end
end

return CircleTalentCell
