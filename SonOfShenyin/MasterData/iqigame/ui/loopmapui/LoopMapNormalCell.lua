-- chunkname: @IQIGame\\UI\\LoopMapUI\\LoopMapNormalCell.lua

local LoopMapNormalCell = classF(LoopMapBaseCell)

function LoopMapNormalCell:ctor(param)
	self.type = Constant.LoopMapCellType.Normal

	LuaUtility.SetImageColorWithGameObject(self.gameObject, 0.6320754, 0.6320754, 0.6320754, 1)
	LuaUtility.SetGameObjectShow(self.view.normalCell, true)
end

function LoopMapNormalCell:OnDragging()
	local index = 1

	for _, v in pairs(self.connectList) do
		if index ~= 1 then
			logError(string.format("\xA1\xBE\xCF\xDF·ͼ\xA1\xBF\xC6\xD5ͨ\xB8\xF1\xD7\xD3 name = %s,ӵ\xD3в\xBBֹһ\xCC\xF5ͨ·"), self.gameObject.name)

			return
		end

		if v.input == Constant.LoopMapDirection.Top then
			if v.output == Constant.LoopMapDirection.Top then
				logError("\xA1\xBE\xCF\xDF·ͼ\xA1\xBF\xCA\xE4\xC8\xEB\xBA\xCD\xCA\xE4\xB3\xF6ͬ\xB7\xBD\xCF\xF2\xA3\xAC\xC9\xCF\xC9\xCF")
			elseif v.output == Constant.LoopMapDirection.Bottom then
				self:SetTop2Bottom()
			elseif v.output == Constant.LoopMapDirection.Left then
				self:SetTop2Left()
			elseif v.output == Constant.LoopMapDirection.Right then
				self:SetTop2Right()
			elseif v.output == Constant.LoopMapDirection.Null then
				self:SetTop2Bottom()
			end
		elseif v.input == Constant.LoopMapDirection.Bottom then
			if v.output == Constant.LoopMapDirection.Top then
				self:SetTop2Bottom()
			elseif v.output == Constant.LoopMapDirection.Bottom then
				logError("\xA1\xBE\xCF\xDF·ͼ\xA1\xBF\xCA\xE4\xC8\xEB\xBA\xCD\xCA\xE4\xB3\xF6ͬ\xB7\xBD\xCF\xF2\xA3\xAC\xCF\xC2\xCF\xC2")
			elseif v.output == Constant.LoopMapDirection.Left then
				self:SetBottom2Left()
			elseif v.output == Constant.LoopMapDirection.Right then
				self:SetBottom2Right()
			elseif v.output == Constant.LoopMapDirection.Null then
				self:SetTop2Bottom()
			end
		elseif v.input == Constant.LoopMapDirection.Left then
			if v.output == Constant.LoopMapDirection.Top then
				self:SetTop2Left()
			elseif v.output == Constant.LoopMapDirection.Bottom then
				self:SetBottom2Left()
			elseif v.output == Constant.LoopMapDirection.Left then
				logError("\xA1\xBE\xCF\xDF·ͼ\xA1\xBF\xCA\xE4\xC8\xEB\xBA\xCD\xCA\xE4\xB3\xF6ͬ\xB7\xBD\xCF\xF2\xA3\xAC\xD7\xF3\xD7\xF3")
			elseif v.output == Constant.LoopMapDirection.Right then
				self:SetLeft2Right()
			elseif v.output == Constant.LoopMapDirection.Null then
				self:SetLeft2Right()
			end
		elseif v.input == Constant.LoopMapDirection.Right then
			if v.output == Constant.LoopMapDirection.Top then
				self:SetTop2Right()
			elseif v.output == Constant.LoopMapDirection.Bottom then
				self:SetBottom2Right()
			elseif v.output == Constant.LoopMapDirection.Left then
				self:SetLeft2Right()
			elseif v.output == Constant.LoopMapDirection.Right then
				logError("\xA1\xBE\xCF\xDF·ͼ\xA1\xBF\xCA\xE4\xC8\xEB\xBA\xCD\xCA\xE4\xB3\xF6ͬ\xB7\xBD\xCF\xF2\xA3\xAC\xD3\xD2\xD3\xD2")
			elseif v.output == Constant.LoopMapDirection.Null then
				self:SetLeft2Right()
			end
		elseif v.input == Constant.LoopMapDirection.Null then
			if v.output == Constant.LoopMapDirection.Top then
				self:SetTop2Bottom()
			elseif v.output == Constant.LoopMapDirection.Bottom then
				self:SetTop2Bottom()
			elseif v.output == Constant.LoopMapDirection.Left then
				self:SetLeft2Right()
			elseif v.output == Constant.LoopMapDirection.Right then
				self:SetLeft2Right()
			elseif v.output == Constant.LoopMapDirection.Null then
				logError("\xA1\xBE\xCF\xDF·ͼ\xA1\xBF\xCA\xE4\xC8\xEB\xBA\xCD\xCA\xE4\xB3\xF6ͬ\xB7\xBD\xCF\xF2\xA3\xAC\xCE\xDE\xCE\xDE")
			end
		end

		index = index + 1
	end
end

function LoopMapNormalCell:SetTop2Bottom()
	LuaUtility.SetGameObjectShow(self.view.curve, false)
	LuaUtility.SetRotationWithTransform(self.view.straight.transform, 0, 0, -90)
	LuaUtility.SetGameObjectShow(self.view.straight, true)
end

function LoopMapNormalCell:SetLeft2Right()
	LuaUtility.SetGameObjectShow(self.view.curve, false)
	LuaUtility.SetRotationWithTransform(self.view.straight.transform, 0, 0, 0)
	LuaUtility.SetGameObjectShow(self.view.straight, true)
end

function LoopMapNormalCell:SetTop2Left()
	LuaUtility.SetGameObjectShow(self.view.straight, false)
	LuaUtility.SetRotationWithTransform(self.view.curve.transform, 0, 0, -90)
	LuaUtility.SetGameObjectShow(self.view.curve, true)
end

function LoopMapNormalCell:SetTop2Right()
	LuaUtility.SetGameObjectShow(self.view.straight, false)
	LuaUtility.SetRotationWithTransform(self.view.curve.transform, 0, 0, -180)
	LuaUtility.SetGameObjectShow(self.view.curve, true)
end

function LoopMapNormalCell:SetBottom2Left()
	LuaUtility.SetGameObjectShow(self.view.straight, false)
	LuaUtility.SetRotationWithTransform(self.view.curve.transform, 0, 0, 0)
	LuaUtility.SetGameObjectShow(self.view.curve, true)
end

function LoopMapNormalCell:SetBottom2Right()
	LuaUtility.SetGameObjectShow(self.view.straight, false)
	LuaUtility.SetRotationWithTransform(self.view.curve.transform, 0, 0, 90)
	LuaUtility.SetGameObjectShow(self.view.curve, true)
end

function LoopMapNormalCell:RevertState()
	LuaUtility.SetGameObjectShow(self.view.straight, false)
	LuaUtility.SetGameObjectShow(self.view.curve, false)
	LuaUtility.SetRotationWithTransform(self.view.curve.transform, 0, 0, 0)
	LuaUtility.SetRotationWithTransform(self.view.straight.transform, 0, 0, 0)
	self:SetIsAddInList(false)

	self.connectList = {}
end

return LoopMapNormalCell
