local items = {}
local height = 199
local num = 0
local tweenDelay = 0

function Refresh(_data)
	AddItem(_data)
end

function AddItem(list)
	if(list) then
		items = items or {}
		for i, v in ipairs(list) do
			num = num + 1
			ResUtil:CreateUIGOAsync("DungeonDetail/DungeonGoodsItem", passNode, function(go)
				local lua = ComUtil.GetLuaTable(go)
				lua.SetIndex(num)
				lua.Refresh(v.data, v.elseData)
				lua.SetTween(tweenDelay)
				table.insert(items, lua)
			end)
		end
		SetLayoutHeight(math.floor(num / 8))
	end
end

function SetLayoutHeight(idx)
	local w, _ = CSAPI.GetRTSize(gameObject)
	CSAPI.SetRTSize(gameObject, w, height + idx * 222)
end

function ShowLine(isShow)
	CSAPI.SetGOActive(lineObj, isShow)
end

function SetTitle(str)
	if str == nil or str == "" then
		return
	end
	CSAPI.SetText(txt_title,str)
end

function SetTweenDelay(idx)
	tweenDelay = 50 *(idx - 1)
end 