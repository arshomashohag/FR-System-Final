#!/bin/bash
#This console is to run the whole application. Follow the instructions to do it.
python -c 'print("This console is to run the whole application. Follow the instructions to do it.")'

# Train model
read -p "Do you want to train the model first?[y/n]: " response

if [ "$response" == "y" ]
 then
    python -c 'from src.train import ModelTraining;model_training = ModelTraining();model_training.train_model();model_training.reset_data_processor()'
fi

#Save embedding calculator model to disk
python -c 'from src.models.CustomModel import ImageEmbedding;embedding_calculator = ImageEmbedding();embedding_calculator.save_model_to_disk("embedding-calculator.h5")'

#Calculate image embeddings and generate candidate products from each gender-articleType group
python -c 'from src.models.CustomModel import EmbeddingCalculator;embedding_calculator = EmbeddingCalculator();embedding_calculator.calculate_all_embeddings();embedding_calculator.save_embeddings_to_pickle();embedding_calculator.generate_candidate_products();'

# Make recommendation by image id (Known recommendation)
python -c 'from src.inference import Inference;inferrer = Inference();inferrer.recommend_by_id(1542);inferrer.show_recommendation();'

#Make recommendation by image path with no filtering(Unknown recommendation)
python -c 'from src.inference import Inference;inferrer = Inference();inferrer.recommend_by_image("data/inference/brush.jpg");inferrer.show_recommendation();'

#Make recommendation by image path with filtering(Unknown recommendation)
python -c 'from src.inference import Inference;inferrer = Inference();inferrer.recommend_by_image("data/inference/brush.jpg", article_type="Shoe Accessories");inferrer.show_recommendation();'