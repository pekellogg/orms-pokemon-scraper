class Pokemon

    attr_accessor :id, :name, :type, :db

    def initialize(id:, name:, type:, db:)
        @id, @name, @type, @db = id, name, type, db
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type) 
            VALUES (?, ?)
        SQL
        db.execute(sql, name, type)
        id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id_lookup, db)
        sql = <<-SQL
            SELECT * FROM pokemon WHERE id = ?
        SQL
        poke_record = db.execute(sql, id_lookup).flatten
        new_pokey = self.new(id: poke_record[0], name: poke_record[1], type: poke_record[2], db: db)
    end
end
