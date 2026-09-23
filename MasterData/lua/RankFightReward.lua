local info = nil
local cfg = nil
local items = {}
local rewards = nil

function Refresh(_data)
    info = _data
    cfg = info and info.cfg
    if cfg and cfg.infos and cfg.infos[1] and cfg.infos[1].reward then
        rewards = cfg.infos[1].reward
        SetItems()
    end
end

function SetItems()
    items = items or {}
	local item = nil
    if #items > 0 then
        for i = 1, #items do
            CSAPI.SetGOActive(items[i].gameObject, false)
        end
    end
	for i, v in ipairs(rewards) do		
		local reward = {id = v[1], num = v[2], type = v[3]}
		if(i <= #items) then
			local result, clickCB = GridFakeData(reward)
			item = items[i]
			CSAPI.SetGOActive(item.gameObject, true)
			item.Refresh(result)
			item.SetClickCB(clickCB)
            item.SetCount()
		else
			item = ResUtil:CreateRandRewardGrid(reward,grid.transform)
            item.SetCount()
			table.insert(items, item)
		end
	end
end