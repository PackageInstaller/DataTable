local this = {};

--回合结束
function this:Handle(data)   
    local datas = data and data.datas;
    if(not datas)then
        return;
    end      
    
    FightActionUtil:PushServerDatas(datas);   
end

return this;