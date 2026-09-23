local time=0;
function Show(name,txt,_time)
    if name and txt and _time then
        CSAPI.SetGOActive(gameObject,true);
        CSAPI.SetGOActive(showTween,true);
        CSAPI.SetGOActive(hideTween,false);
        CSAPI.SetText(txtName,name);
        CSAPI.SetText(txtInfo,txt);
        time= _time and _time+0.4 or 0;
    end
end

function Hide()
    time=0;
    if IsNil(gameObject) then
        do return end
    end
    CSAPI.SetGOActive(gameObject,false);
    CSAPI.SetGOActive(showTween,false);
    CSAPI.SetGOActive(hideTween,true);
end

function Update()
    if time>0 then
        time=time-Time.deltaTime;
        if time<=0 then
            Hide()
        end
    end
end