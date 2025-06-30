-- chunkname: @IQIGame\\UI\\Lottery\\LotteryShowSoulClickController.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	if self.SoulBtnGroup ~= nil then
		self.SoulBtnMap = {}
		self.SoulBtnHandler = {}

		for i = 0, self.SoulBtnGroup.transform.childCount - 1 do
			local childTrans = self.SoulBtnGroup.transform:GetChild(i)
			local soulCid = tonumber(childTrans.name)

			if soulCid ~= nil then
				local cfgSoulData = CfgSoulTable[soulCid]

				if cfgSoulData ~= nil then
					self.SoulBtnMap[soulCid] = childTrans.gameObject:GetComponent("Button")
					self.SoulBtnHandler[soulCid] = function()
						self:OnClickSoul(soulCid)
					end
				else
					logError("找不到灵魂 " .. soulCid .. " 检查按钮名是否正确。按钮名：" .. childTrans.name)
				end
			else
				logError("按钮名称必须是灵魂id 而不是 \"" .. childTrans.name .. "\"")
			end
		end
	end

	if self.EquipBtnGroup ~= nil then
		self.EquipBtnMap = {}
		self.EquipBtnHandler = {}

		for i = 0, self.EquipBtnGroup.transform.childCount - 1 do
			local childTrans = self.EquipBtnGroup.transform:GetChild(i)
			local equipCid = tonumber(childTrans.name)

			if equipCid ~= nil then
				local cfgItemData = CfgItemTable[equipCid]

				if cfgItemData ~= nil then
					self.EquipBtnMap[equipCid] = childTrans.gameObject:GetComponent("Button")
					self.EquipBtnHandler[equipCid] = function()
						self:OnClickEquip(equipCid)
					end
				else
					logError("找不到蕴灵 " .. equipCid .. " 检查按钮名是否正确。按钮名：" .. childTrans.name)
				end
			else
				logError("按钮名称必须是蕴灵id 而不是 \"" .. childTrans.name .. "\"")
			end
		end
	end

	self:AddListeners()
end

function m:AddListeners()
	if self.SoulBtnMap ~= nil then
		for soulCid, button in pairs(self.SoulBtnMap) do
			button.onClick:AddListener(self.SoulBtnHandler[soulCid])
		end
	end

	if self.EquipBtnMap ~= nil then
		for equipCid, button in pairs(self.EquipBtnMap) do
			button.onClick:AddListener(self.EquipBtnHandler[equipCid])
		end
	end
end

function m:RemoveListeners()
	if self.SoulBtnMap ~= nil then
		for soulCid, button in pairs(self.SoulBtnMap) do
			button.onClick:RemoveListener(self.SoulBtnHandler[soulCid])
		end
	end

	if self.EquipBtnMap ~= nil then
		for equipCid, button in pairs(self.EquipBtnMap) do
			button.onClick:RemoveListener(self.EquipBtnHandler[equipCid])
		end
	end
end

function m:OnClickSoul(soulCid)
	local soulData = SoulModule.GetSoulData(soulCid)

	UIModule.Open(Constant.UIControllerName.SoulLockUI, Constant.UILayer.UI, soulData)
end

function m:OnClickEquip(equipCid)
	local itemData = ItemData.CreateByCIDAndNumber(equipCid, 1, false)

	UIModule.Open(Constant.UIControllerName.EquipUI, Constant.UILayer.UI, {
		forShow = true,
		data = {
			itemData
		}
	})
end

function m:Destroy()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
