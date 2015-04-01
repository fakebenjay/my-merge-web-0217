describe Hash do
  describe "#my_merge" do

    let(:vowels) { {"a" => 1, "e" => 2, "i" => 3} }
    let(:consonants) { {"b" => 4, "c" => 5, "d" => 6} } 
    let(:alphabet) { {"a"=>"apple", "b"=>"banana", "c"=> "carrot", "e" => "egg"} }

    it "doesn't change the original hash" do
      vowels.my_merge(consonants)
      expect(vowels).to eq(vowels)
    end

    it "doesn't change the hash passed as an argument" do
      vowels.my_merge(consonants)
      expect(consonants).to eq(consonants)
    end

    it "doesn't use clone" do
      expect_any_instance_of(Hash).to_not receive(:clone)
      vowels.my_merge(consonants)
    end

    it "doesn't use #merge" do     
      expect_any_instance_of(Hash).to_not receive(:merge)
      vowels.my_merge(consonants)
    end

    context "no block given" do
      context "no duplicate keys" do
        it "returns a new hash where the first key, value pairs are from the
        hash the method was called on and the last come from the hash passed
        as an argument" do
          expect(vowels.my_merge(consonants)).to eq({"a"=>1, "e"=>2, "i"=>3, "b"=>4, "c"=>5, "d"=>6})
          expect(consonants.my_merge(vowels)).to eq({"b"=>4, "c"=>5, "d"=>6, "a"=>1, "e"=>2, "i"=>3})
        end
      end
      context "duplicate keys" do
        it "prioritizes the values for the keys in the hash passed as an argument" do
          expect(alphabet.merge(vowels)).to eq({"a"=>1, "b"=>"banana", "c"=>"carrot", "e"=>2, "i"=>3})
          expect(vowels.merge(alphabet)).to eq({"a"=>"apple", "e"=>"egg", "i"=>3, "b"=>"banana", "c"=>"carrot"})
        end
      end
    end

    context "block given" do
      context "no duplicate keys" do
        it "executes the block to determine each key, value pair" do
          h1 = { "a" => 1, "b" => 2 }
          h2 = { "c" => 3, "d" => 4 }
          result = h1.merge(h2) { |key, oldval, newval| newval - oldval }
          expect(result.keys.length).to eq(4)
          expect(result).to eq({"a"=>1, "b"=>2, "c"=>3, "d"=>4})
        end
      end
      context "duplicate keys" do
        it "executes the block to determine each key, value pair" do
          h1 = { "a" => 100, "b" => 200 }
          h2 = { "b" => 254, "c" => 300 }
          result = h1.merge(h2) { |key, oldval, newval| newval - oldval }
          expect(result.keys.length).to eq(3)
          expect(result).to eq({"a"=>100, "b"=>54, "c"=>300})
        end
      end
    end
  end
end
