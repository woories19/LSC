RegisterNetEvent('savevehProps')
AddEventHandler('savevehProps', function(vehProps)
    MySQL.Async.execute("INSERT INTO vehmods (id, name, args) VALUES(@source, @name, @args)",     
    --[[ 
        (id, name, args)
        These are the columns (in our database) we will be insterting the data into  
    ]]
    {["@source"] = GetPlayerIdentifiers(source)[1], ["@name"] = GetPlayerName(source), ["@args"] = (json.encode (vehProps))},

        function (result)

    end)
end)

RegisterNetEvent('getvehProps')
AddEventHandler('getvehProps', function()
    local src = source
    MySQL.Async.fetchAll("SELECT * FROM vehmods WHERE id = @id", { ['@id'] = GetPlayerIdentifiers(src)[1] }, function (results)
        TriggerClientEvent('loadvehMods', src, results[1].args)
    end)
end)

