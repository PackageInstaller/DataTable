-- chunkname: @IQIGame\\UI\\Lottery\\LotteryShowClickController.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:RegisterButtonHero()
	self:RegisterButtonSkill()
	self:AddListeners()
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:RegisterButtonHero()
	if self.HeroBtnGroup ~= nil then
		self.HeroBtnMap = {}
		self.HeroBtnHandler = {}

		for i = 0, self.HeroBtnGroup.transform.childCount - 1 do
			local childTrans = self.HeroBtnGroup.transform:GetChild(i)
			local itemCid = tonumber(childTrans.name)

			if itemCid ~= nil then
				local cfgData = CfgHeroTable[itemCid]

				if cfgData ~= nil then
					self.HeroBtnMap[itemCid] = childTrans.gameObject:GetComponent("Button")
					self.HeroBtnHandler[itemCid] = function()
						return
					end
				else
					logError("找不到物品 " .. itemCid .. " 检查按钮名是否正确。按钮名：" .. childTrans.name)
				end
			else
				logError("按钮名称必须是物品id 而不是 \"" .. childTrans.name .. "\"")
			end
		end
	end
end

function m:RegisterButtonSkill()
	if self.SkillBtnGroup ~= nil then
		self.SkillBtnMap = {}
		self.SkillBtnHandler = {}

		for i = 0, self.SkillBtnGroup.transform.childCount - 1 do
			local childTrans = self.SkillBtnGroup.transform:GetChild(i)
			local itemCid = tonumber(childTrans.name)

			if itemCid ~= nil then
				local cfgData = CfgItemTable[itemCid]

				if cfgData ~= nil then
					self.SkillBtnMap[itemCid] = childTrans.gameObject:GetComponent("Button")
					self.SkillBtnHandler[itemCid] = function()
						return
					end
				else
					logError("找不到物品 " .. itemCid .. " 检查按钮名是否正确。按钮名：" .. childTrans.name)
				end
			else
				logError("按钮名称必须是物品id 而不是 \"" .. childTrans.name .. "\"")
			end
		end
	end
end

function m:AddListeners()
	if self.HeroBtnMap ~= nil then
		for itemCid, button in pairs(self.HeroBtnMap) do
			button.onClick:AddListener(self.HeroBtnHandler[itemCid])
		end
	end

	if self.SkillBtnMap ~= nil then
		for itemCid, button in pairs(self.SkillBtnMap) do
			button.onClick:AddListener(self.SkillBtnHandler[itemCid])
		end
	end
end

function m:RemoveListeners()
	if self.HeroBtnMap ~= nil then
		for itemCid, button in pairs(self.HeroBtnMap) do
			button.onClick:RemoveListener(self.HeroBtnHandler[itemCid])
		end
	end

	if self.SkillBtnMap ~= nil then
		for itemCid, button in pairs(self.SkillBtnMap) do
			button.onClick:RemoveListener(self.SkillBtnHandler[itemCid])
		end
	end
end

function m:RefreshHeroData()
	return
end

function m:RefreshSkillData()
	return
end

function m:LoadImg(path, obj)
	AssetUtil.LoadImage(self, path, obj:GetComponent("Image"))
end

function m:OnClickHero(itemCid)
	UIModule.Open(Constant.UIControllerName.RoleDetailsUI, Constant.UILayer.UI, {
		[2] = {
			itemCid
		}
	})
end

function m:OnClickSkill(itemCid)
	return
end

function m:Dispose()
	self:RemoveListeners()

	if self.ItemCellList ~= nil then
		for k, v in pairs(self.ItemCellList) do
			v:Dispose()
		end

		self.ItemCellList = nil
	end

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
