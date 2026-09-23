local ids = {}
local layout = nil
local curDatas = {}

function Awake()
	layout = ComUtil.GetCom(vsv, "UIInfinite")
	layout:Init("UIs/Grid/UnitGridItem", LayoutCallBack, true)
end

function LayoutCallBack(index)
	local lua = layout:GetItemLua(index)
	if(lua) then
		local _data = curDatas[index]
		lua.Refresh(_data)
	end
end

function OnOpen()
	ids = data	
	if(#ids > 0) then		
		Refresh()
	end
end

function Refresh()
	RefreshPanel()
end

function RefreshPanel()
	CSAPI.SetGOActive(txtNull, #ids < 1)
	if(#ids > 0) then
		table.sort(ids, function(a, b)
			local cardData1 = RoleMgr:GetData(a)
			local cardData2 = RoleMgr:GetData(b)
			if(cardData1 and cardData2) or(not cardData1 and not cardData2) then
				local cfg1 = Cfgs.CardData:GetByID(a)
				local cfg2 = Cfgs.CardData:GetByID(b)	
				if(cfg1.quality == cfg2.quality) then
					return a < b
				else
					return cfg1.quality > cfg2.quality
				end
			else
				return cardData1 ~= nil
			end
		end)
		curDatas = ids or {}	
		layout:IEShowList(#curDatas)	
	end
end

function OnClickBack()
	view:Close()
end 