function Awake()    
    txtLeftTurn = ComUtil.GetCom(leftTurn,"Text");
end

function OnOpen()
    if(data)then
        local leftTurnNum = data;
        SetValue(leftTurnNum);        
    end
    FuncUtil:Call(Close,nil,2500);
end

function SetValue(leftTurnNum)    
    txtLeftTurn.text = tostring(leftTurnNum);    
end

function Close() 
    if(not IsNil(view) and view.Close)then
        view:Close();
    end
end
