local item = nil

--info:{data, cid, num, type}
function Refresh(info,elseData)
    local reward = {id = info.cid,num = info.num}
    if reward then
        if not item  then
            item = ResUtil:CreateRandRewardGrid(reward,itemParent.transform)
        else
            local result, clickCB = GridFakeData(reward)
            item.Refresh(result)
			item.SetClickCB(clickCB)
        end
    end
    CSAPI.SetGOActive(getObj,elseData and elseData.isGet)
end